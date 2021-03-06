@DictoRails.module "WordSetsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base

    initialize: (options) ->
      wordSets = App.request "word:sets:entities"

      App.execute "when:fetched", wordSets, =>
        wordSet = wordSets.get(options.id)

        if wordSet?
          @layout = @getLayoutView wordSet

          wordSet.fetch()
          App.execute "when:fetched", wordSet, =>
            @listenTo @layout, "show", =>
              @wordSetRegion(wordSet)
              @categoriesRegion(wordSet)
              @usersRegion(wordSet)

          @show @layout,
            loading: true
        else
          @show new App.Views.Shared.NotFound


    wordSetRegion: (wordSet) ->
      wordSetView = @getWordSetView wordSet

      @listenTo wordSetView, "word:delete:clicked", (args) ->
        if App.request "delete:word:set", args.model
          App.vent.trigger "word:deleted", args.model
        else
          alert("You can't do that!")

      @layout.wordSetRegion.show wordSetView

    categoriesRegion: (wordSet) ->
      @categoriesController = new Show.CategoriesApp.Controller {
        region: @layout.categoriesRegion
        wordSet
      }

    usersRegion: (wordSet) ->
      @categoriesController = new Show.UsersApp.Controller {
        region: @layout.usersRegion
        wordSet
      }


    getLayoutView: (model) ->
      new Show.Layout { model }

    getWordSetView: (wordSet) ->
      new Show.WordSet
        model: wordSet
