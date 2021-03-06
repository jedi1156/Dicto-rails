@DictoRails.module "WordsApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Layout extends App.Views.Layout
    template: "words/show/show_layout"

    regions:
      wordRegion:       ".words-show-word-region"
      categoriesRegion: ".words-show-categories-region"
      meaningsRegion:   ".words-show-meanings-region"

    triggers:
      "click .word-edit"   : "edit:word:clicked"
      "click .word-delete" : "delete:word:clicked"


  class Show.Word extends App.Views.ItemView
    template: "words/show/word"


  class Show.Error extends App.Views.ItemView
    template: "words/show/error"
