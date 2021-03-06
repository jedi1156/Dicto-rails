@DictoRails.module "LearnApp", (LearnApp, App, Backbone, Marionette, $, _) ->

  class LearnApp.Router extends Marionette.AppRouter
    appRoutes:
      "learn"                              : "list"
      "learn/:word_set_id"                 : "show"
      "learn/:word_set_id/"                : "study"
      "learn/:word_set_id/:category_ids"   : "study"


  class LearnApp.Controller extends App.Controllers.Base

    list: ->
      new LearnApp.List.Controller

    show: (word_set_id) ->
      new LearnApp.Show.Controller { word_set_id }

    study: (word_set_id, category_ids = "") ->
      new LearnApp.Study.Controller { word_set_id, category_ids }


  App.addInitializer ->
    controller = new LearnApp.Controller
    new LearnApp.Router { controller }
