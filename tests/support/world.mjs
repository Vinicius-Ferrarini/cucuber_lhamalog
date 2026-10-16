import { setWorldConstructor, World } from '@cucumber/cucumber';
export class TestWorld extends World {
  constructor(options) {
    super(options);
    this.scenarioId = undefined;
    this.page = undefined;
    this.context = undefined;
    this.browser = undefined;
    this.state = {};
  }
}
setWorldConstructor(TestWorld);
