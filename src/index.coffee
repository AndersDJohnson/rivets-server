fs = require 'fs'
jsdomApi = require('jsdom/lib/old-api')
jsdom = jsdomApi.jsdom
serializeDocument = jsdomApi.serializeDocument

rivetsPath = require.resolve('rivets')
rivetsSrc = fs.readFileSync(rivetsPath)

module.exports = rivetsServer = {}

rivetsServer.render = (html, locals = {}, callback) ->

  defaults =
    fullDoc: false

  options = locals.options || {}

  for own key of defaults
    options[key] ?= defaults[key]

  jsdom.env({
    html: html
    src: [rivetsSrc],
    done: (errs, window) ->
      if options.configure
        options.configure(window.rivets)
      root = window.document.documentElement
      window.rivets.bind(root, locals, options)
      if options.fullDoc
        rendered = serializeDocument(window.document)
      else
        rendered = window.document.body.innerHTML
      callback(errs, rendered)
  })
