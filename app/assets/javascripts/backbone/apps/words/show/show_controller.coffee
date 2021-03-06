@DictoRails.module "WordsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.LeftFrame

    initialize: (options) ->
      { word, word_set_id, id } = options
      word ||= App.request "word:entity", { word_set_id, id }

      @layout = @getLayoutView word

      @listenTo @layout, "edit:word:clicked", ->
        App.vent.trigger "edit:word", word

      @listenTo @layout, "delete:word:clicked", (args) ->
        if App.request "delete:word", args.model
          App.vent.trigger "word:deleted", args.model
        else
          alert("You can't do that!")

      @listenTo @layout, "show", =>
        @wordRegion word
        @categoriesRegion word
        @meaningsRegion word

      App.execute "when:fetched", word, (error) =>
        scheme = App.request "scheme:entity"
        scheme.set("text", word.get("text"))

        App.vent.trigger "words:search"

      @show @layout,
        loading:
          error: =>
            @layout = null
            @show new App.Views.Shared.NotFound


    wordRegion: (word) ->
      wordView = @getWordView word
      @layout.wordRegion.show wordView

    categoriesRegion: (model) ->
      region = @layout.categoriesRegion
      App.vent.trigger "list:word:categories", { model, region }

    meaningsRegion: (word) ->
      App.vent.trigger "list:meanings", word, @layout.meaningsRegion


    getLayoutView: (word) ->
      new Show.Layout
        model: word

    getWordView: (word) ->
      new Show.Word
        model: word
