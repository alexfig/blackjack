class window.BlackjackHandView extends Backbone.View
  initialize: (params)-> 
    @name = params.name;
    @hand = params.hand;
    @model.on 'hit stand', => @render()
    #@listenToOnce(@model,'endGame', =>@render())
    #@hand.on 'add', =>@render()
    @handView = new HandView(collection:@hand);
    @render()

  render: ->
    @handView.render();
    @$el.children().detach()
    @$el.append('<h2>'+@name+'(<span class="score"></span>)</h2>').addClass(@name)
    @$el.append @handView.$el
    @$('.score').text @model.getHighestScore(@hand)

