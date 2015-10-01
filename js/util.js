var util = {
  template: function (templateName) {
    return JST[templateName];
  },
  renderTemplate: function (templateName, options) {
    return this.template(templateName)(options);
  }
};