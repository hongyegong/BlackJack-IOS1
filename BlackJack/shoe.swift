//
//  shoe.swift
//  BlackJack
//
//  Created by 鸿烨 弓 on 15/2/11.
//  Copyright (c) 2015年 鸿烨 弓. All rights reserved.
//

import Foundation

class Shoe {
    var decks:[Deck] = []
    
    //constructor
    init (number:Int = 1) {
            var tempDeck = Deck ()
            tempDeck.createDeck()
            decks.append(tempDeck)
    }
    
    //getting rid of all decks, used for new game
    func removeAllDeck() {
        decks.removeAll(keepCapacity: false);
    }
    
    func displayAll() {
        for x in 0..<decks.count {
            for i in 0..<decks[x].cards.count {
                NSLog("\(decks[x].cards[i].description)")
                
            }
        }
    }
    
    
}
