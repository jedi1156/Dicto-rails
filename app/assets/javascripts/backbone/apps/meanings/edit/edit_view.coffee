@DictoRails.module "MeaningsApp.Edit", (Edit, App, Backbone, Marionette, $, _) ->

  class Edit.View extends App.Views.ItemView
    template: "meanings/edit/meaning"

    form:
      className: "form-horizontal form-page"
      panel: false
