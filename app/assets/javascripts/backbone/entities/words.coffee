@DictoRails.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Word extends App.Entities.Model

    relations: [
      type:             Backbone.Many
      key:              'meanings'
      collectionType:   Entities.Meanings
      relatedModel:     Entities.Meaning
    ,
      type:             Backbone.Many
      key:              'categories'
      relatedModel:     Entities.Categories.Model
    ]

    defaults:
      text:           ""
      pronounciation: ""
      meanings:       []

    initialize: (options) ->
      query = _.pick(options, 'scheme', 'category_ids')
      @urlRoot = -> Routes.word_set_words_path(options.word_set_id, query)

  class Entities.Words extends App.Entities.Collection
    model: Entities.Word

    initialize: (options) ->
      query = _.pick(options, 'scheme', 'category_ids')
      @url = -> Routes.word_set_words_path(options.word_set_id, query)

    statistics: (status) ->
      percent = @where({ status }).length * 100 / @length
      percent.toFixed(2)


  API =
    getWords: (options) ->
      words = new Entities.Words(options)
      words.fetch
        reset: true
      words

    getWord: (options) ->
      word = new Entities.Word(options)
      word.fetch()
      word

    newWord: (options) ->
      new Entities.Word(options)


  App.reqres.setHandler "words:entities", (options) ->
    API.getWords(options)

  App.reqres.setHandler "word:entity", (options) ->
    API.getWord(options)

  App.reqres.setHandler "new:word:entity", (options) ->
    API.newWord(options)
