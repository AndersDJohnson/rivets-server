(function() {
  var fs, jsdom, jsdomApi, rivetsPath, rivetsServer, rivetsSrc, serializeDocument,
    hasProp = {}.hasOwnProperty;

  fs = require('fs');

  jsdomApi = require('jsdom/lib/old-api');

  jsdom = jsdomApi.jsdom;

  serializeDocument = jsdomApi.serializeDocument;

  rivetsPath = require.resolve('rivets');

  rivetsSrc = fs.readFileSync(rivetsPath);

  module.exports = rivetsServer = {};

  rivetsServer.render = function(html, locals, callback) {
    var defaults, key, options;
    if (locals == null) {
      locals = {};
    }
    defaults = {
      fullDoc: false
    };
    options = locals.options || {};
    for (key in defaults) {
      if (!hasProp.call(defaults, key)) continue;
      if (options[key] == null) {
        options[key] = defaults[key];
      }
    }
    return jsdom.env({
      html: html,
      src: [rivetsSrc],
      done: function(errs, window) {
        var rendered, root;
        if (options.configure) {
          options.configure(window.rivets);
        }
        root = window.document.documentElement;
        window.rivets.bind(root, locals, options);
        if (options.fullDoc) {
          rendered = serializeDocument(window.document);
        } else {
          rendered = window.document.body.innerHTML;
        }
        return callback(errs, rendered);
      }
    });
  };

}).call(this);

//# sourceMappingURL=index.js.map
