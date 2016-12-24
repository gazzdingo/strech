StrechView = require './strech-view'
{CompositeDisposable} = require 'atom'

module.exports = Strech =
  strechView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @strechView = new StrechView(state.strechViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @strechView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
          "strech:toggle":  => @toggle()
          "strech:enable":  => @enable()
          "strech:disable": => @disable()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @strechView.destroy()

  serialize: ->
    strechViewState: @strechView.serialize()

  toggle: ->
    console.log 'Strech was toggled!'
    
    enable: ->
        @active = true
        @powerEditor.enable()

    disable: ->
        @active = false
        @powerEditor.disable()


    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
