fs = require 'fs'
jsdom = require('jsdom').jsdom

rivetsPath = require.resolve('rivets')
rivetsSrc = fs.readFileSync(rivetsPath)

module.exports = rivetsServer = {}

rivetsServer.render = (html, data = {}, options = {}, callback) ->

  unless callback?
    callback ?= options
    options = {}

  defaults =
    fullDoc: false

  for own key of defaults
    options[key] ?= defaults[key]

  jsdom.env({
    html: html
    src: [rivetsSrc],
    done: (errs, window) ->
      if options.configure
        options.configure(window.rivets)
      root = window.document.documentElement
      window.rivets.bind(root, data, options)
      if options.fullDoc
        doctype = window.document.doctype?.toString() || ''
        rendered = doctype + root.outerHTML
      else
        rendered = window.document.body.innerHTML
      callback(errs, rendered)
  })
