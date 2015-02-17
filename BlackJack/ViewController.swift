//
//  ViewController.swift
//  BlackJack
//
//  Created by 鸿烨 弓 on 15/2/11.
//  Copyright (c) 2015年 鸿烨 弓. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var plLabels:[UILabel] = []
    var dlLabels:[UILabel] = []
    var blackjack:Game!
    var gamecount : Int = 0
    var isstart:Bool = false
    var bet:Int = 0
    @IBOutlet weak var restartButtor: UIButton!
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var plBet: UITextField!
    @IBOutlet weak var plSum: UILabel!
    @IBOutlet weak var plCardOne: UILabel!
    @IBOutlet weak var plCardTwo: UILabel!
    @IBOutlet weak var plCardThree: UILabel!
    @IBOutlet weak var plCardFour: UILabel!
    @IBOutlet weak var plCardFive: UILabel!
    @IBOutlet weak var plCardSix: UILabel!
    
    @IBOutlet weak var plScore: UILabel!
    
    @IBOutlet weak var dlCardOne: UILabel!
    
    @IBOutlet weak var dlCardTwo: UILabel!

    @IBOutlet weak var dlScore: UILabel!
    
    @IBAction func hit(sender: UIButton) {
        
        if(toDouble(plBet.text) == nil || plBet.text.toInt() < 0 || plBet.text.toInt() > blackjack.player.amount){
            let alertController = UIAlertController(title: "BlackJack", message:
                "Please bet a proper number!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }else if(plBet.text.toInt() == 0 && isstart == true){
            let alertController = UIAlertController(title: "BlackJack", message:
                "Please Bet!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return
            
        }
        
        bet = plBet.text.toInt()!
        blackjack.hit(blackjack.currentPlayer)
        var temp:Int = blackjack.player.checkScore().intScore
        if ( temp > 21) {
            for x in 0..<blackjack.player.cards.count {plLabels[x].text = nil}
            blackjack.stand(blackjack.currentPlayer)
        };getPlayerStats()
    }

    @IBAction func stand(sender: UIButton) {
        blackjack.stand(0)
        getPlayerStats()
    }
    
    @IBAction func restart(sender: UIButton) {
        gamecount = gamecount + 1
        //make shuffle after five games
        if(gamecount == 5){
            blackjack.shoe.decks[blackjack.currentDeck].shuffle()
            blackjack.shoe = Shoe(number: 1)
            gamecount = 0;
            
        }
        
        restartButtor.hidden = true
        hitButton.hidden = false
        standButton.hidden = false
        blackjack.player.stand = false
        
        for x in 0..<blackjack.player.cards.count {plLabels[x].text = nil}
        for i in 0..<2 {dlLabels[i].text = nil}
        dlScore.text = nil
        plLabels.removeAll(keepCapacity: true)
        dlLabels.removeAll(keepCapacity: true)
        
        blackjack.player.cards.removeAll(keepCapacity: false)
        blackjack.dealer.cards.removeAll(keepCapacity: false)
        
        plLabels += [plCardOne, plCardTwo, plCardThree, plCardFour, plCardFive, plCardSix]
        dlLabels += [dlCardOne, dlCardTwo]
        

        blackjack.currentDeck = 0;
        for k in 0..<2{blackjack.player.addCard(blackjack.getCard(blackjack.currentDeck)!)}
        blackjack.dealer.addCard(blackjack.getCard(blackjack.currentDeck)!)
        blackjack.dealer.addCard(blackjack.getCard(blackjack.currentDeck)!)
        blackjack.dealer.hiddenCard = blackjack.dealer.cards[0]
        
        plScore.text = "\(blackjack.player.checkScore().intScore)"
        getPlayerStats()
    }
    func refresh(){
        for a in 0..<blackjack.player.cards.count {
            plLabels[a].text = blackjack.player.cards[a].cd;
            plScore.text = blackjack.player.checkScore().strScore
        }
        
        for b in 0..<blackjack.dealer.cards.count {
            dlLabels[b].text = blackjack.dealer.cards[b].cd
        }
    }
    
    func checkScore(playerScore:Int, dealerScore:Int) -> String {
        if playerScore > 21 {
            blackjack.player.amount -= bet
            return ("Over 21, you lost!")
            
        }
        if dealerScore > 21  {
            blackjack.player.amount += bet
            return ("Dealer sucks, you won!")
        }
        if dealerScore == 21 && playerScore != 21 {
            blackjack.player.amount -= bet
            return ("Dealer has BlackJack, you lost!")
        }
        if (playerScore == 21 && dealerScore != 21) {
            blackjack.player.amount += bet
            return ("BlackJack, you won!")
        }
        if (playerScore > dealerScore) {
            blackjack.player.amount += bet
            return ("You Won")
        }
        if dealerScore > playerScore {
            blackjack.player.amount -= bet
            return ("House Won")
        }
        return ("Tie")
    }
    
    func toDouble(str: String) -> Double? {
        var formatter = NSNumberFormatter()
        if let number = formatter.numberFromString(str) {
            return number.doubleValue
        }
        return nil
    }


    //function will be called to get cards of each player and display them in each players UIImageView
    
    func getPlayerStats() {
        
        var stand_:Int = 0
        refresh()
        //if number of stands matches number players, that means dealer can go
        if (blackjack.player.stand == true) {stand_ = stand_ + 1}
        
        //if all plays stood, code below gets executed
        if (stand_ > 0) {
            dlLabels[0].text = blackjack.dealer.unhide()?.cd
            hitButton.hidden = true;standButton.hidden = true
            while (blackjack.dealer.checkScore("s").intScore < 16) {blackjack.dealer.addCard(blackjack.getCard(blackjack.currentDeck)!)}
            //for x in 0..<plLabels.count {plLabels[x].text = nil}
            //for i in 0..<dlLabels.count {dlLabels[i].text = nil}
            var str = blackjack.dealer.checkScore().intScore
            dlScore.text = "\(str)"
            plScore.text = checkScore(blackjack.player.checkScore().intScore, dealerScore: blackjack.dealer.checkScore("a").intScore)
            
            restartButtor.hidden = false

            if(blackjack.player.amount < 1){
            let alertController = UIAlertController(title: "BlackJack", message:
                "GAME OVER!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Restart", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            blackjack.player.amount = 100
                for x in 0..<blackjack.player.cards.count {plLabels[x].text = nil}
                for i in 0..<2 {dlLabels[i].text = nil}
                dlScore.text = nil
                plLabels.removeAll(keepCapacity: true)
                dlLabels.removeAll(keepCapacity: true)
                
                blackjack.player.cards.removeAll(keepCapacity: false)
                blackjack.dealer.cards.removeAll(keepCapacity: false)
                restartButtor.hidden = true
                hitButton.hidden = false
                standButton.hidden = false
            viewDidLoad()
            }
        }
        
        plSum.text = "\(blackjack.player.amount)"
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        plLabels += [plCardOne, plCardTwo, plCardThree, plCardFour, plCardFive, plCardSix]
        dlLabels += [dlCardOne, dlCardTwo]
        blackjack = Game(deckSize: 1,playerNumber: 1)
        getPlayerStats()
        isstart = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

