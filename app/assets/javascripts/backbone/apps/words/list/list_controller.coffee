@DictoRails.module "WordsApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: (options) ->
      words = App.request "words:entities", options

      App.execute "when:fetched", words, =>
        wordsView = @getWordsView words
        @show wordsView

    getWordsView: (words) ->
      new List.Words
        collection: words
