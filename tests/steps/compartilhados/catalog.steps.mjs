import { defineStep } from '@cucumber/cucumber';
import { readFileSync } from 'node:fs';
import { handlers as ocorrencias } from '../ocorrencias/implementations.mjs';
import { handlers as dashboards } from '../dashboards-relatorios/implementations.mjs';
import { handlers as login } from '../login/implementations.mjs';
const modules = { ocorrencias, 'dashboards-relatorios': dashboards, login };
const merged = new Map();
for (const [module, handlers] of Object.entries(modules)) {
  const catalog = JSON.parse(readFileSync(new URL(`../${module}/catalog.json`, import.meta.url), 'utf8'));
  for (const entry of catalog) {
    const all = merged.get(entry.text) ?? [];
    all.push(...entry.bindings.map(binding => ({ ...binding, module, handlers })));
    merged.set(entry.text, all);
  }
}
// Âncoras e texto literal evitam steps genéricos que casam com cenários diferentes.
// O catálogo inclui a expansão das tabelas; ao mudar um .feature, rode npm run validar.
const escape = s => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
for (const [text, candidates] of merged) {
  defineStep(new RegExp(`^${escape(text)}$`), async function () {
    const matches = candidates.filter(x => x.scenarioId === this.scenarioId);
    if (!matches.length) throw new Error(`Catálogo fora de sincronia para ${this.scenarioId}`);
    const unique = [...new Map(matches.map(x => [x.stepId, x])).values()];
    if (unique.length !== 1) throw new Error(`Binding ambíguo em ${this.scenarioId}: ${text}`);
    const binding = unique[0];
    const handler = binding.handlers[binding.stepId];
    if (!handler) {
      this.log(`IMPLEMENTAR ${binding.module}/${binding.stepId} (${this.scenarioId})`);
      return 'pending';
    }
    return await handler({ world: this, parameters: binding.parameters, text, template: binding.template, scenarioId: this.scenarioId });
  });
}
