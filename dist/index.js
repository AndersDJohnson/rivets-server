(function() {
  var fs, jsdom, rivetsPath, rivetsServer, rivetsSrc,
    __hasProp = {}.hasOwnProperty;

  fs = require('fs');

  jsdom = require('jsdom').jsdom;

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
      if (!__hasProp.call(defaults, key)) continue;
      if (options[key] == null) {
        options[key] = defaults[key];
      }
    }
    return jsdom.env({
      html: html,
      src: [rivetsSrc],
      done: function(errs, window) {
        var doctype, rendered, root, _ref;
        if (options.configure) {
          options.configure(window.rivets);
        }
        root = window.document.documentElement;
        window.rivets.bind(root, locals, options);
        if (options.fullDoc) {
          doctype = ((_ref = window.document.doctype) != null ? _ref.toString() : void 0) || '';
          rendered = doctype + root.outerHTML;
        } else {
          rendered = window.document.body.innerHTML;
        }
        return callback(errs, rendered);
      }
    });
  };

}).call(this);

//# sourceMappingURL=../dist/index.js.map
