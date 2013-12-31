# rivets-server

Render [Rivets.js][rivets] templates on the server.

## Installation

  $ npm install rivets-server

## Usage

```javascript
var rivetsServer = require('rivets-server');
var template = '<span rv-text="name"></span>'
var data = {
  name: 'Anders'
};
rivetsServer.render(template, data, function (err, html) {
  // now, html == '<span rv-text="name">Anders</span>'
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

