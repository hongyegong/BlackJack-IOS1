//
//  Person.swift
//  BlackJack
//
//  Created by 鸿烨 弓 on 15/2/11.
//  Copyright (c) 2015年 鸿烨 弓. All rights reserved.
//

import UIKit
import Foundation
class Person {
    var playerName:String
    var score: Double = 0.0
    var cards:[Card] = []
    
    
    //constructor
    init (name: String) {
        self.playerName = name
    }
    
    //receives a card and gets added to cards arrays
    func addCard(card: Card) {
        cards.append(card);
    }
    
    //stand functions for each player
    func stand() {
        
    }
    
    //checking the score of each player
    func checkScore() -> (intScore: Int, strScore: String) {
        var intScore:Int = 0
        for ndx in cards {intScore += ndx.rank.values.first}
        
        //A could be 1 or 11
        if(intScore <= 11){
            for i in cards {
                if(i.rank.simpleDescription() == "A" ){
                    intScore += (i.rank.values.second! - 1)
                    break
                }
            }
        }
        var strScore:String = "\(intScore)"
        return (intScore, strScore)
    }
}
