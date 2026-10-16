const support = ['tests/support/**/*.mjs', 'tests/steps/compartilhados/*.steps.mjs'];
const common = { import: support, parallel: 1, strict: true, format: ['progress'] };
const product = ['tests/features/ocorrencias/**/*.feature', 'tests/features/dashboards-relatorios/**/*.feature', 'tests/features/login/**/*.feature'];
export default () => ({
  exemplo: { ...common, paths: ['tests/features/referencia-local/*.feature'], format: ['progress', 'json:reports/exemplo.json', 'html:reports/exemplo.html'] },
  'exemplo-red': { ...common, paths: ['tests/features/referencia-local/*.feature'], format: ['progress', 'json:reports/exemplo-red.json', 'html:reports/exemplo-red.html'] },
  planos: { ...common, paths: product, format: ['progress', 'json:reports/planos.json', 'html:reports/planos.html'] },
  inventario: { ...common, paths: product, dryRun: true, format: ['summary', 'json:reports/inventario.json'] },
  front: { ...common, paths: product, tags: '@front and not @api and not @integracao', format: ['progress', 'json:reports/front.json', 'html:reports/front.html'] },
  integracao: { ...common, paths: product, tags: '@integracao', format: ['progress', 'json:reports/integracao.json', 'html:reports/integracao.html'] },
  api: { ...common, paths: product, tags: '@api', format: ['progress', 'json:reports/api.json', 'html:reports/api.html'] }
});
