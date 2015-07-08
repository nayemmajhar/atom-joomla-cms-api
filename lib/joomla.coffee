JoomlaView = require './joomla-view'
{CompositeDisposable} = require 'atom'

module.exports = Joomla =
  joomlaView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @joomlaView = new JoomlaView(state.joomlaViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @joomlaView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'joomla:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @joomlaView.destroy()

  serialize: ->
    joomlaViewState: @joomlaView.serialize()

  toggle: ->
    console.log 'Joomla was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
