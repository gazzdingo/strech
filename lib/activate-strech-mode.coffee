{CompositeDisposable} = require "atom"

configSchema = require "./config-schema"
powerEditor = require "./power-editor"

module.exports = ActivateStrechMode =
  config: configSchema
  subscriptions: null
  active: false
  powerEditor: powerEditor

  activate: (state) ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add "atom-workspace",
      "activate-strech-mode:toggle":  => @toggle()
      "activate-strech-mode:enable":  => @enable()
      "activate-strech-mode:disable": => @disable()

    if @getConfig "autoToggle"
      @toggle()

  deactivate: ->
    @subscriptions?.dispose()
    @active = false
    @powerEditor.disable()

  getConfig: (config) ->
    atom.config.get "activate-strech-mode.#{config}"

  toggle: ->
    if @active then @disable() else @enable()

  enable: ->
    @active = true
    @powerEditor.enable()

  disable: ->
    @active = false
    @powerEditor.disable()
