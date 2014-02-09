@DictoRails.module "Entities.UserWordSets", (UserWordSets, App, Backbone, Marionette, $, _) ->

  class UserWordSets.Model extends App.Entities.Model
    urlRoot: -> Routes.word_set_user_word_sets_path(@get("word_set_id"))

    defaults:
      permissions: "r"

    relations: [
      type:             Backbone.One
      key:              "user"
      relatedModel:     "DictoRails.Entities.Users.Model"
    ]

  class UserWordSets.Collection extends App.Entities.Collection
    model: UserWordSets.Model
    url: -> Routes.word_set_user_word_sets_path(@word_set_id)

    initialize: (collection, options = {}) ->
      { @word_set_id } = options


  class UserWordSets.Controller extends App.Controllers.Base

    getUserWordSets: (word_set_id) ->
      user_word_sets = new UserWordSets.Collection([], { word_set_id })
      user_word_sets.fetch
        reset: true
      user_word_sets


  UserWordSets.on "start", ->
    controller = new UserWordSets.Controller

    App.reqres.setHandler "user:word:set:entities", (word_set_id) ->
      controller.getUserWordSets(word_set_id)
