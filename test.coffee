fs = require 'fs'
assert = require('chai').assert
sinon = require 'sinon'
Plugin = require './'

describe 'Plugin', ->

  beforeEach ->
    @fixture = './test-fixture.html'
    @plugin = new Plugin { optimize: true, paths: { public: @fixture } }

  it 'should be defined', ->
    assert.ok @plugin

  it 'should have an onCompile method', ->
    assert.ok typeof @plugin.onCompile is 'function'

  it 'should run if `optimize` option is true', ->
    execute = sinon.stub @plugin, 'execute'
    @plugin.onCompile()
    assert.ok execute.called

  it 'should not run if `optimize` option is false', ->
    execute = sinon.stub @plugin, 'execute'
    @plugin.config.optimize = false
    @plugin.onCompile()
    assert.ok !execute.called

  it 'should use git sha as replace value', ->
    execute = sinon.stub @plugin, 'execute', (..., callback) -> callback('abcdef')
    replace = sinon.stub @plugin, 'replace'
    @plugin.onCompile()
    assert.ok replace.calledWith 'abcdef'

  xit 'should handle error if getting git sha fails'

  it 'should replace instances of token with digest', ->
    data = fs.readFileSync @fixture, { encoding: 'utf8' }
    assert.ok data.match(/\?DIGEST/g).length is 3

    @plugin.replace 'abcdef'

    data = fs.readFileSync @fixture, { encoding: 'utf8' }
    assert.ok data.match(/\?abcdef/g).length is 3

    undo = data.replace /\?abcdef/g, '?DIGEST'
    fs.writeFileSync @fixture, undo
