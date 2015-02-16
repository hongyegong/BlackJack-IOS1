//
//  Player.swift
//  BlackJack
//
//  Created by 鸿烨 弓 on 15/2/11.
//  Copyright (c) 2015年 鸿烨 弓. All rights reserved.
//

import Foundation
class Player : Person {
    var bet:Int = 0
    var stand:Bool = false
    var amount: Int = 100
    //constuctor
    override init (name:String = "Player") {
        super.init(name: name)
    }
    
    //changing the value for stand attribute
    var setStand:Bool {
        get {return self.stand}
        set(newBoolValue) { self.stand = newBoolValue}
    }
    
}
