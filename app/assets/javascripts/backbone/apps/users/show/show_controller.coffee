@DictoRails.module "UsersApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base

    initialize: (options) ->
      { id } = options
      @model = App.request "user:entity", id

      @layout = @getLayout()

      @listenTo @layout, "show", =>
        @userRegion()
        @userWordSetsRegion()

      @show @layout,
        loading:
          error: =>
            @layout = null
            @show(new App.Views.Shared.NotFound)


    userRegion: ->
      userView = @getUserView()
      @layout.userRegion.show userView

    userWordSetsRegion: ->
      region = @layout.userWordSetsRegion
      new Show.InvitationsApp.Controller { user: @model, region }


    getLayout: ->
      new Show.Layout { @model }

    getUserView: ->
      new Show.User { @model }
