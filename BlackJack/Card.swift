//
//  Card.swift
//  BlackJack
//
//  Created by 鸿烨 弓 on 15/2/11.
//  Copyright (c) 2015年 鸿烨 弓. All rights reserved.
//

import Foundation


import Foundation
import UIKit
enum Suit: Character{
    case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "♠"
        case .Hearts:
            return "♡"
        case .Diamonds:
            return "♢"
        case .Clubs:
            return "♣"
        }
    }
}

enum Rank: Int {
    case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King, Ace
    func simpleDescription() -> String {
        switch self {
        case .King:
            return "K"
        case .Queen:
            return "Q"
        case .Jack:
            return "J"
        case .Ace:
            return "ace"
        default:
            return "\(self.rawValue)"
        }
    }
    struct Values {
        let first: Int, second: Int?
    }
    var values: Values {
        switch self {
        case .Ace:
            return Values(first: 1, second: 11)
        case .Jack, .Queen, .King:
            return Values(first: 10, second: nil)
        default:
            return Values(first: self.rawValue, second: nil)
        }
    }
}
struct Card {
    var currentCard:Int = 0
    var cd:String?
    var suit: Suit
    var rank: Rank
    var hidden:Bool = false
    init(rank: Rank, suit: Suit, cardNum: String) {
        self.suit = suit
        self.rank = rank
        self.cd = cardNum
    }
    var description: String {
        var output = "\(suit.rawValue),"
        output += "\(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}