//
//  Dealer.swift
//  BlackJack
//
//  Created by 鸿烨 弓 on 15/2/11.
//  Copyright (c) 2015年 鸿烨 弓. All rights reserved.
//

import UIKit
import Foundation
class Dealer : Person {
    var hiddenCard:Card?
    
    //constructor
    override init (name:String = "Dealer") {
        super.init(name: name)
    }
    
    //this is a dealer specific function, unhiding cards dealer has
    func unhide() -> Card? {
        cards[0].cd = hiddenCard?.cd!
        return cards[0]
    }
    
    //this function behaves differently for dealer
    func checkScore(type:String) -> (intScore: Int, strScore: String) {
        if (type == "hidden") {
            var intScore:Int = 0
            for ndx in cards {intScore += ndx.rank.values.first}
            intScore = intScore - cards[0].rank.values.first
            var strScore:String = "\(intScore)"
            return (intScore, strScore) }
        else {
            var intScore:Int = 0
            for ndx in cards {intScore += ndx.rank.values.first}
            var strScore:String = "\(intScore)"
            return (intScore, strScore)
        }
    }
}
