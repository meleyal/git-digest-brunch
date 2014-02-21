replace = require 'replace'
chomp = require 'chomp'
exec = require('child_process').exec

module.exports = class GitDigest

  brunchPlugin: true

  constructor: (@config) ->

  execute: (command, callback) ->
    exec command, (error, stdout, stderr) -> callback stdout

  onCompile: ->
    @execute 'git rev-parse --short HEAD', @replace

  replace: (digest) =>
    replace
      regex: /\?DIGEST/g
      replacement: '?' + digest.chomp()
      paths: [@config.paths.public]
      recursive: true
      silent: true
