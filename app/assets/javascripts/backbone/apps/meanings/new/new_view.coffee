@DictoRails.module "MeaningsApp.New", (New, App, Backbone, Marionette, $, _) ->

  class New.View extends App.Views.ItemView
    template: "meanings/new/meaning"

    form:
      className: "form-horizontal form-page"
      panel: false
