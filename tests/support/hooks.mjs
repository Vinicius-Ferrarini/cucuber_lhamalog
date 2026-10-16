import { Before, After, setDefaultTimeout } from '@cucumber/cucumber';
setDefaultTimeout(30_000);
Before(function ({ pickle }) {
  this.scenarioId = pickle.tags.map(t => t.name.slice(1)).find(t => /^LLT(84|85|86)_C\d+$/.test(t));
  this.state = {};
});
After(async function () {
  // Contextos são isolados por cenário. Não capturamos screenshots/logs de sessões reais automaticamente.
  try { await this.context?.close(); } finally { await this.browser?.close(); }
});
