@DictoRails = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.on "initialize:before", (options) ->
    App.environment = options.environment
    App.currentUser = options.currentUser

  App.addRegions
    headerRegion:   "#header-region"
    mainRegion:     "#main-region"

  App.rootRoute = "word_sets"

  App.reqres.setHandler "default:region", ->
    App.mainRegion

  App.addInitializer ->
    App.module("Entities").start()
    App.module("HeaderApp").start()

  App.commands.setHandler "register:instance", (instance, id) ->
    App.register instance, id if App.environment is "development"

  App.commands.setHandler "unregister:instance", (instance, id) ->
    App.unregister instance, id if App.environment is "development"

  App.on "initialize:after", (options) ->
    @startHistory()
    @navigate(@rootRoute, trigger: true) unless @getCurrentRoute()

  App
