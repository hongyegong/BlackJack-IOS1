//
//  Game.swift
//  BlackJack
//
//  Created by 鸿烨 弓 on 15/2/11.
//  Copyright (c) 2015年 鸿烨 弓. All rights reserved.
//

import Foundation
import UIKit

class Game {
    var shoe:Shoe
    var player:Player = Player()
    var players:[Player] = []
    var dealer: Dealer = Dealer()
    var currentPlayer:Int = 0
    var currentDeck:Int = 0
    
    //constructor
    init (deckSize:Int, playerNumber:Int) {
        //shoe reference
        shoe = Shoe(number: deckSize)
        for i in 0..<playerNumber { addPlayer() }
        //initially each player is given 2 cards.
        for pl in players {for i in 0..<2{pl.addCard(getCard(currentDeck)!)}}
        dealer.addCard(getCard(currentDeck)!)
        dealer.addCard(getCard(currentDeck)!)
        dealer.hiddenCard = dealer.cards[0]
    }
    
    //adding new player to the game
    func addPlayer() {
        var newPlayer:Player = Player();
        players.append(newPlayer)
    }
    
    //gets a card from the Shoe and current deck
    func getCard(deckNdx:Int) -> Card? {
        if (shoe.decks[currentDeck].cards.count <= 10 ) {currentDeck = currentDeck + 1 }
        return shoe.decks[deckNdx].drawCard()!
    }
    
    //calls the hit function for player at playerNdx index
    func hit (playerNdx:Int) {
        var card = getCard(currentDeck)
        players[playerNdx].addCard(card!)
    }
    
    //calls the stand function for player at playerNdx index
    func stand (playerNdx:Int) {
        if (players[playerNdx].stand == false ) {
            players[playerNdx].setStand = true
            currentPlayer = currentPlayer + 1
            if (currentPlayer > players.count - 1) {currentPlayer = 0}
        }
        else {
            currentPlayer = currentPlayer + 1
            if (currentPlayer > players.count - 1) {currentPlayer = 0}
        }
    }
    
    
}

