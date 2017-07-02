rivetsServer = require '../../'
assert = require('chai').assert

describe 'rivets-server', ->

  describe 'render', ->
    locals = null

    beforeEach ->
      locals =
        name: 'Joe'

    it 'fragment', (done) ->
      rivetsServer.render '<span rv-text="name"></span>', locals, (err, html) ->
        assert.equal(html, '<span rv-text="name">Joe</span>')
        done()

    it 'full html', (done) ->
      locals.options = {
        fullDoc: true
      }
      rivetsServer.render '''
        <html><body rv-text="name"></body></html>
      ''',
      locals,
      (err, html) ->
        assert.equal(html, '''
          <html><head></head><body rv-text="name">Joe</body></html>
        ''')
        done()

    it 'with doctype', (done) ->
      locals.options = {
        fullDoc: true
      }
      rivetsServer.render '''
        <!DOCTYPE html>
        <html><head></head><body rv-text="name"></body></html>
      ''',
      locals,
      (err, html) ->
        assert.equal(html, '''
          <!DOCTYPE html><html><head></head><body rv-text="name">Joe</body></html>
        ''')
        done()


  describe 'revive', ->
    locals = null

    beforeEach ->
      locals =
        happy: true

    describe 'if', ->

      it 'true', (done) ->
        rivetsServer.render '<span rv-if="happy">Yay!</span>', locals, (err, html) ->
          expected = '<!-- rivets: if @happy@ @&lt;span rv-if="happy"&gt;Yay!&lt;/span&gt;@ -->' +
            '<span>Yay!</span>'
          assert.equal(html, expected)
          done()

      it 'false', (done) ->
        locals.happy = false
        rivetsServer.render '<span rv-if="happy">Yay!</span>', locals, (err, html) ->
          expected = '<!-- rivets: if @happy@ @&lt;span rv-if="happy"&gt;Yay!&lt;/span&gt;@ -->'
          assert.equal(html, expected)
          done()
