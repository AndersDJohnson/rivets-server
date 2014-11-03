# rivets-server

[![NPM version](https://badge.fury.io/js/rivets-server.png)](http://badge.fury.io/js/rivets-server)
[![NPM dependencies](https://david-dm.org/AndersDJohnson/rivets-server.png)](https://david-dm.org/AndersDJohnson/rivets-server)
[![Build Status](https://travis-ci.org/AndersDJohnson/rivets-server.png)](https://travis-ci.org/AndersDJohnson/rivets-server)


Render [Rivets.js][rivets] templates on the server. Let Rivets pick up again on the client, if you want.

Advantages:
- Friendly to search engines and browsers without JavaScript
- Potential for faster "time-to-content" in mobile experience
- Use the same templating language on client & server

By default, it currently uses [my fork of Rivets][my-rivets], which supports
restoring bindings from Rivets on the client-side, such as `{text}` bindings and empty `if` and `each` bindings.
Vanilla Rivets can't currently persist or restore this information.
See my pull request at: [github.com/mikeric/rivets/pull/253](https://github.com/mikeric/rivets/pull/253)

Conforms to the [Consolidate.js][consolidate] API.
Uses [jsdom] to run Rivets against templates.

## Installation

```sh
  $ npm install rivets-server
```

## Usage

It's easy!

```javascript
var rivetsServer = require('rivets-server');
var template = '<span rv-text="name"></span>';
var locals = {
  name: 'Anders'
};
rivetsServer.render(template, locals, function (err, html) {
  // now, html == '<span rv-text="name">Anders</span>'
});
```

If you want to render a full HTML document, pass the `fullDoc` option as follows.

```javascript
var rivetsServer = require('rivets-server');
var template = '<!doctype html><html><body>...</body></html>';
var locals = {
  options: {
    fullDoc: true
  }
};
rivetsServer.render(template, locals, function (err, html) { /* ... */ };
```

You may need to provide modified [Rivets adapters](http://www.rivetsjs.com/docs/#adapters).
For example, if you have custom adapters for pub-sub on the client, but only have JSON models on the server,
then you might want to alias all adapters to the default `'.'` adapter.

```javascript
var rivetsServer = require('rivets-server');
// ...
var locals = {
  options: {
    configure: function (rivets) {
      rivets.adapters[':'] = rivets.adapters['.'];
    }
  }
};
rivetsServer.render(template, locals, function (err, html) { /* ... */ };
```


[my-rivets]: https://github.com/AndersDJohnson/rivets/tree/revival
[rivets]: http://rivetsjs.com/
[jsdom]: https://github.com/tmpvar/jsdom
[consolidate]: https://github.com/visionmedia/consolidate.js/

