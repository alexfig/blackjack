assert = chai.assert

describe 'Blackjack', ->
  game = null
  deck = null
  playerHand = null
  dealerHand = null

  beforeEach ->
    game = new Blackjack()
    deck = game.get('deck')
    playerHand = game.get('playerHand')
    dealerHand = game.get('dealerHand')

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      game.hit(playerHand);
      assert.strictEqual deck.length, 47

  describe 'stand', ->
    it 'should not give card to player', ->
      cardCount = playerHand.length
      game.stand(playerHand, dealerHand);
      assert.strictEqual playerHand.length, cardCount

  describe 'bust', ->
    it 'should cause the player to bust', ->
      playerHand.add([new Card(rank:10), new Card(rank:10)])
      game.checkBust(playerHand)
      assert.equal game.gameOver, true

  describe 'win', ->
    it 'should have the player beat the dealer', ->
      playerHand.reset([new Card(rank:10), new Card(rank:10)])
      dealerHand.reset([new Card(rank:7), new Card(rank:10)])
      game.playDealer(playerHand, dealerHand)
      assert.equal game.gameOver, true
