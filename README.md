# rivets-server

Render [Rivets.js][rivets] templates on the server.

Advantages:
- Friendly to search engines and browsers without JavaScript
- Potential for faster first render on mobile devices
- Use the same templating language on client & server

## Installation

  $ npm install rivets-server

## Usage

It's easy!

```javascript
var rivetsServer = require('rivets-server');
var template = '<span rv-text="name"></span>';
var data = {
  name: 'Anders'
};
rivetsServer.render(template, data, function (err, html) {
  // now, html == '<span rv-text="name">Anders</span>'
});
```

If you want to render a full HTML document, pass the `fullDoc` option as follows.

```javascript
var rivetsServer = require('rivets-server');
var template = '<!doctype html><html><body>...</body></html>';
var data = {};
var options = {
  fullDoc: true
};
rivetsServer.render(template, data, options, function (err, html) {
  // ...
});
```


## Details

Conforms to the [Consolidate.js][consolidate] API.

Uses [jsdom] as a context for Rivets to bind.

By default, it currently uses [my fork of Rivets][my-rivets], which supports
restoring `if` and `each` bindings from Rivets on the client-side.
Vanilla Rivets can't currently persist or restore this information.


[my-rivets]: https://github.com/AndersDJohnson/rivets/tree/revival
[rivets]: http://www.rivetsjs.com/docs/ "Rivets.js"
[jsdom]: https://github.com/tmpvar/jsdom
[consolidate]: https://github.com/visionmedia/consolidate.js/

