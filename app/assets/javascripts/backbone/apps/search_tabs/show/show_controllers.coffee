@DictoRails.module "SearchTabsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base

    initialize: (options) ->
      { model } = options
      scheme = App.request "scheme:entity"
      model.search scheme.get("text")

      searchTabView = @getSearchTabView model

      @listenTo searchTabView, "track:active:element", ->
        App.vent.trigger "track:active:element"

      @listenTo searchTabView, "search:tab:loaded", ->
        App.vent.trigger "focus:stolen"

      @show searchTabView


    getSearchTabView: (model) ->
      new Show.SearchTab { model }
