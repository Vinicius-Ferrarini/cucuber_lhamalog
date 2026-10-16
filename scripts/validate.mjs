import { readFileSync, readdirSync } from 'node:fs';
import { spawnSync } from 'node:child_process';
import assert from 'node:assert/strict';
import { fileURLToPath } from 'node:url';
const trace = JSON.parse(readFileSync('docs/rastreabilidade.json', 'utf8'));
assert.equal(trace.cases.length, trace.scenarios);
assert.equal(trace.cases.reduce((n, c) => n + c.examples, 0), trace.exampleRows);
for (const id of new Set(trace.cases.map(c => c.task))) {
  const group = trace.cases.filter(c => c.task === id);
  assert.equal(new Set(group.map(c => c.id)).size, group.length);
  group.forEach((c, index) => assert.equal(c.id, `${id.replace('-', '')}_C${String(index + 1).padStart(2, '0')}`));
}
for (const item of trace.cases) {
  const content = readFileSync(item.feature, 'utf8');
  assert.ok(content.includes(`@${item.id} `));
  assert.ok(content.includes('# language: pt'));
}
for (const module of ['ocorrencias', 'dashboards-relatorios', 'login']) {
  const entries = JSON.parse(readFileSync(`tests/steps/${module}/catalog.json`, 'utf8'));
  for (const entry of entries) {
    for (const id of new Set(entry.bindings.map(b => b.scenarioId))) {
      assert.equal(new Set(entry.bindings.filter(b => b.scenarioId === id).map(b => b.stepId)).size, 1,
        `Binding ambíguo: ${id} ${entry.text}`);
    }
  }
}
console.log(`Inventário: ${trace.scenarios} cenários sequenciais, ${trace.exampleRows} exemplos e referências presentes.`);
const result = spawnSync(process.execPath, [fileURLToPath(new URL('./run.mjs', import.meta.url)), 'inventario'], { stdio: 'inherit' });
if (result.error) throw result.error;
if (result.status !== 0) process.exit(result.status ?? 1);
const report = JSON.parse(readFileSync('reports/inventario.json', 'utf8'));
const observed = new Map();
for (const feature of report) {
  for (const scenario of feature.elements ?? []) {
    if (scenario.type !== 'scenario') continue;
    const id = scenario.tags.map(t => t.name.slice(1)).find(t => /^LLT(84|85|86)_C\d+$/.test(t));
    assert.ok(id, `Cenário sem ID em ${feature.uri}`);
    observed.set(id, (observed.get(id) || 0) + 1);
  }
}
for (const item of trace.cases) assert.equal(observed.get(item.id), item.examples, `Exemplos fora de sincronia: ${item.id}`);
assert.equal(observed.size, trace.cases.length);
console.log('Catálogos sem ambiguidade; exemplos reais dos arquivos .feature conferidos com a rastreabilidade.');
