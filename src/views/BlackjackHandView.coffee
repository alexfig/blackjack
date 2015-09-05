class window.BlackjackHandView extends Backbone.View
  initialize: (params)-> 
    @name = params.name;
    @hand = params.hand;
    @model.on 'hit stand', => @render()
    @model.on 'change', =>@render()
    @hand.on 'add', =>@render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.append('<h2>'+@name+'(<span class="score"></span>)</h2>').addClass(@name)
    @$el.append new HandView(collection:@hand).render().
    @$('.score').text @model.getHighestScore(@hand)

