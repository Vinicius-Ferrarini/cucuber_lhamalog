import { readFileSync } from 'node:fs';
import { handlers as ocorrencias } from '../tests/steps/ocorrencias/implementations.mjs';
import { handlers as dashboards } from '../tests/steps/dashboards-relatorios/implementations.mjs';
import { handlers as login } from '../tests/steps/login/implementations.mjs';
const trace = JSON.parse(readFileSync('docs/rastreabilidade.json', 'utf8'));
for (const [module, handlers] of Object.entries({ ocorrencias, 'dashboards-relatorios': dashboards, login })) {
  const catalog = JSON.parse(readFileSync(`tests/steps/${module}/templates.json`, 'utf8'));
  const cases = trace.cases.filter(c => c.module === module);
  console.log(`${module}: ${cases.length} cenários, ${cases.reduce((n, c) => n + c.examples, 0)} exemplos, ${Object.keys(handlers).length}/${catalog.length} handlers implementados.`);
}
console.log('Presença de handler não comprova teste aprovado. Os planos iniciam pending; a demonstração é somente local.');
