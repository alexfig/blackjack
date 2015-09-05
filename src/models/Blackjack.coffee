class window.Blackjack extends Backbone.Model
  initialize: (param)-> 
    # @set 'deck', deck = new Deck()
    @set 'deck', param.deck
    @dealPlayer(@get 'deck')
    @dealDealer(@get 'deck')
    @on 'hit', => @hit(@get 'playerHand') unless @gameOver
    @on 'stand', => @stand(@get('playerHand'), @get('dealerHand')) unless @gameOver
    @gameOver = false;

  dealPlayer:(deck) -> @set 'playerHand', hand = new Hand [deck.pop(), deck.pop()]

  dealDealer:(deck) -> @set 'dealerHand', hand = new Hand [deck.pop().flip(), deck.pop()]

  hit: (hand) -> 
    hand.add(@get('deck').pop())
    @checkBust(hand)

  stand: (playerHand, dealerHand) ->
    dealerHand.find( (card) -> if !card.get('revealed') then true ).flip()
    @playDealer(playerHand, dealerHand)

  checkBust:(hand) -> 
    if @scores(hand)[0] > 21
      if hand == @get 'dealerHand' 
        @endGame('You Win!')

      else 
        @get('dealerHand').find( (card) -> if !card.get('revealed') then true ).flip()
        @endGame('Busted!')
      #start new game



  hasAce:(hand) -> hand.reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore:(hand) -> hand.reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: (hand) ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(hand), @minScore(hand) + 10 * @hasAce(hand)]


  playDealer: (playerHand, dealerHand) ->
    while not (16 < @scores(dealerHand)[1] <= 21 or @scores(dealerHand)[0] > 16)
      @hit(dealerHand)
    if @gameOver then return;

    @set('dealerScore', @getHighestScore(dealerHand))

    if @getHighestScore(playerHand) < @getHighestScore(dealerHand)
        #dealer wins
        @endGame('Dealer Wins')

    else if @getHighestScore(playerHand) == @getHighestScore(dealerHand)
        #push
        @endGame('Push')
    else
      @endGame('You win!')
    

  getHighestScore: (hand) ->
    scores = @scores(hand)
    if scores[1] <= 21
      return scores[1]
    scores[0]

  endGame: (status)-> 
    @gameOver = true
    @trigger('endGame',status)



