rivetsServer = require '../../'
assert = require('chai').assert

describe 'rivets-server', ->

  describe 'render', ->
    data = null

    beforeEach ->
      data =
        name: 'Joe'

    it 'fragment', (done) ->
      rivetsServer.render '<span rv-text="name"></span>', data, (err, html) ->
        assert.equal(html, '<span rv-text="name">Joe</span>')
        done()

    it 'full html', (done) ->
      rivetsServer.render '''
        <html><body rv-text="name"></body></html>
      ''',
      data,
      {
        fullDoc: true
      },
      (err, html) ->
        assert.equal(html, '''
          <html><body rv-text="name">Joe</body></html>
        ''')
        done()

    it 'with doctype', (done) ->
      rivetsServer.render '''
        <!DOCTYPE html>
        <html><body rv-text="name"></body></html>
      ''',
      data,
      {
        fullDoc: true
      },
      (err, html) ->
        assert.equal(html, '''
          <!DOCTYPE html><html><body rv-text="name">Joe</body></html>
        ''')
        done()


  describe 'revive', ->
    data = null

    beforeEach ->
      data =
        happy: true

    describe 'if', ->

      it 'true', (done) ->
        rivetsServer.render '<span rv-if="happy">Yay!</span>', data, (err, html) ->
          expected = '<!-- rivets: if @happy@ @&lt;span rv-if="happy"&gt;Yay!&lt;/span&gt;@ -->' +
            '<span>Yay!</span>'
          assert.equal(html, expected)
          done()

      it 'false', (done) ->
        data.happy = false
        rivetsServer.render '<span rv-if="happy">Yay!</span>', data, (err, html) ->
          expected = '<!-- rivets: if @happy@ @&lt;span rv-if="happy"&gt;Yay!&lt;/span&gt;@ -->'
          assert.equal(html, expected)
          done()
