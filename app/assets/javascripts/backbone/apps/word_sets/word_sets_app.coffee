@DictoRails.module "WordSetsApp", (WordSetsApp, App, Backbone, Marionette, $, _) ->

  class WordSetsApp.Router extends Marionette.AppRouter
    appRoutes:
      "word_sets"            : "list"


  API =
    list: ->
      new WordSetsApp.List.Controller


  App.addInitializer ->
    new WordSetsApp.Router
      controller: API