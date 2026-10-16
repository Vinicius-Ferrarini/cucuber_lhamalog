import { readFileSync, writeFileSync, readdirSync } from 'node:fs';
import { createHash } from 'node:crypto';
import { Parser, AstBuilder, GherkinClassicTokenMatcher } from '@cucumber/gherkin';
import { IdGenerator } from '@cucumber/messages';
import assert from 'node:assert/strict';
const trace = JSON.parse(readFileSync('docs/rastreabilidade.json', 'utf8'));
const old = new Map(trace.cases.map(c => [c.id, c]));
const cases = [];
const modules = { ocorrencias: '84', 'dashboards-relatorios': '85', login: '86' };
const json = (path, data) => writeFileSync(path, JSON.stringify(data, null, 2) + '\n');
for (const [module, task] of Object.entries(modules)) {
  const catalog = new Map();
  const templates = new Map();
  const dir = `tests/features/${module}`;
  for (const file of readdirSync(dir).filter(f => f.endsWith('.feature')).sort()) {
    const parser = new Parser(new AstBuilder(IdGenerator.incrementing()), new GherkinClassicTokenMatcher());
    const feature = parser.parse(readFileSync(`${dir}/${file}`, 'utf8')).feature;
    assert.ok(feature, `Feature inválida: ${file}`);
    let background = [];
    for (const child of feature.children) {
      if (child.background) { background = child.background.steps; continue; }
      assert.ok(child.scenario, 'Rules exigem ampliar explicitamente este sincronizador antes de utilizá-las.');
      const scenario = child.scenario;
      const tags = [...feature.tags, ...scenario.tags].map(t => t.name);
      const ids = tags.filter(t => /^@LLT(84|85|86)_C\d+$/.test(t));
      assert.equal(ids.length, 1, `Forneça um único ID LLT para ${scenario.name}`);
      const id = ids[0].slice(1);
      assert.ok(id.startsWith(`LLT${task}_`));
      assert.ok(!cases.some(c => c.id === id), `ID duplicado: ${id}`);
      let rows = scenario.examples.flatMap(table => {
        const headers = table.tableHeader.cells.map(c => c.value);
        return table.tableBody.map(row => Object.fromEntries(row.cells.map((cell, i) => [headers[i], cell.value])));
      });
      if (!scenario.examples.length) rows = [{}];
      assert.ok(rows.length, `Exemplos vazios: ${id}`);
      cases.push({ ...old.get(id), id, task: `LLT-${task}`, module, title: scenario.name,
        feature: `${dir}/${file}`, tags, examples: rows.length,
        source: old.get(id)?.source || 'INFORMAR documento correspondente', status: 'verificar_implementacao_no_inventario' });
      for (const step of [...background, ...scenario.steps]) {
        assert.ok(!step.docString && !step.dataTable, 'DocStrings e DataTables em passos exigem ampliar explicitamente o sincronizador e o registro de steps.');
        const template = step.text;
        const stepId = 'S_' + createHash('sha256').update(module + '\0' + template).digest('hex').slice(0, 12);
        const entry = templates.get(stepId) || { id: stepId, template, scenarios: [] };
        if (!entry.scenarios.includes(id)) entry.scenarios.push(id);
        templates.set(stepId, entry);
        for (const row of rows) {
          const text = template.replace(/<([^>]+)>/g, (_, key) => {
            assert.ok(key in row, `Coluna ${key} ausente em ${id}`); return row[key];
          });
          const binding = { scenarioId: id, stepId, parameters: Object.fromEntries(Object.entries(row).filter(([key]) => template.includes(`<${key}>`))), template };
          const expanded = catalog.get(text) || { text, bindings: [] };
          if (!expanded.bindings.some(b => JSON.stringify(b) === JSON.stringify(binding))) expanded.bindings.push(binding);
          catalog.set(text, expanded);
        }
      }
    }
  }
  json(`tests/steps/${module}/catalog.json`, [...catalog.values()]);
  json(`tests/steps/${module}/templates.json`, [...templates.values()]);
}
trace.cases = cases;
trace.scenarios = cases.length;
trace.exampleRows = cases.reduce((n, c) => n + c.examples, 0);
json('docs/rastreabilidade.json', trace);
const lines = ['# Cobertura convertida', '', `${trace.scenarios} cenários e ${trace.exampleRows} linhas de execução. Implementação e resultado devem ser conferidos no inventário e nos relatórios.`, '', '| ID | Cenário | Exemplos | Arquivo |', '| --- | --- | --- | --- |'];
for (const c of cases) lines.push(`| ${c.id} | ${c.title.replaceAll('|', '\\|')} | ${c.examples} | [${c.feature.split('/').at(-1)}](../${c.feature}) |`);
writeFileSync('docs/COBERTURA.md', lines.join('\n') + '\n');
console.log(`Sincronizados ${trace.scenarios} cenários e ${trace.exampleRows} exemplos; implementações existentes foram preservadas.`);
