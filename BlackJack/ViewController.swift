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
    var pLabels:[[UILabel]] = []
    var pl1Labels:[UILabel] = []
    var plScores:[UILabel] = []
    var plBets:[UITextField] = []
    var plSums:[UILabel] = []
    var numDecks:Int!
    var numPlayers:Int!
    var blackjack:Game!
    var gamecount : Int = 0
    var isstart:Bool = false
    var bet:Int = 0
    @IBOutlet weak var restartButtor: UIButton!
    @IBOutlet weak var standButton: UIButton!
    @IBOutlet weak var hitButton: UIButton!
    @IBOutlet weak var plBet: UITextField!
    @IBOutlet weak var pl1Bet: UITextField!
    @IBOutlet weak var plSum: UILabel!
    @IBOutlet weak var plCardOne: UILabel!
    @IBOutlet weak var plCardTwo: UILabel!
    @IBOutlet weak var plCardThree: UILabel!
    @IBOutlet weak var plCardFour: UILabel!
    @IBOutlet weak var plCardFive: UILabel!
    @IBOutlet weak var plCardSix: UILabel!
    
    @IBOutlet weak var plScore: UILabel!
    
    @IBOutlet weak var pl1Score: UILabel!
    @IBOutlet weak var dlCardOne: UILabel!
    
    @IBOutlet weak var dlCardTwo: UILabel!

    @IBOutlet weak var dlScore: UILabel!
    
    @IBOutlet weak var pl1CardOne: UILabel!
    @IBOutlet weak var pl1CardTwo: UILabel!
    @IBOutlet weak var pl1CardThree: UILabel!
    @IBOutlet weak var pl1CardFour: UILabel!
    @IBOutlet weak var pl1CardFive: UILabel!
    
    @IBOutlet weak var pl1Sum: UILabel!
    @IBOutlet weak var pl1CardSix: UILabel!
    
    @IBOutlet weak var dealButton: UIButton!
    
    
    @IBAction func Deal(sender: UIButton) {
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
        
        hitButton.hidden = false
        standButton.hidden = false
        dealButton.hidden = true
        for i in 0..<blackjack.players.count {for k in 0..<2{blackjack.players[i].addCard(blackjack.getCard(blackjack.currentDeck)!)}}
        blackjack.dealer.addCard(blackjack.getCard(blackjack.currentDeck)!)
        blackjack.dealer.addCard(blackjack.getCard(blackjack.currentDeck)!)
        blackjack.dealer.hiddenCard = blackjack.dealer.cards[0]
        
        for i in 0..<blackjack.players.count {plScores[i].text = "\(blackjack.player.checkScore().intScore)"}
        getPlayerStats()
    }
    
    func isBet() -> Bool{
        for i in 0..<blackjack.players.count {if(toDouble(plBets[i].text) == nil || plBets[i].text.toInt() < 0 || plBets[i].text.toInt() > blackjack.players[i].amount){
            let alertController = UIAlertController(title: "BlackJack", message:
                "Please bet a proper number!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
        }else if(plBets[i].text.toInt() == 0 && isstart == true){
            let alertController = UIAlertController(title: "BlackJack", message:
                "Please Bet!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            return false
            
            }}
        return true
    }
    @IBAction func hit(sender: UIButton) {
        
        if !isBet() {return}
        //bet = plBets[blackjack.currentPlayer].text.toInt()!
        blackjack.hit(blackjack.currentPlayer)
        var temp:Int = blackjack.players[blackjack.currentPlayer].checkScore().intScore
        if ( temp > 21) {
            for x in 0..<blackjack.players[blackjack.currentPlayer].cards.count {pLabels[blackjack.currentPlayer][x].text = nil}
            blackjack.stand(blackjack.currentPlayer)
        }
        getPlayerStats()
    }

    @IBAction func stand(sender: UIButton) {
        
        if !isBet() {return}
        //plTurns[blackjack.currentPlayer].hidden = true
        blackjack.stand(blackjack.currentPlayer)
        getPlayerStats()
    }
    
    @IBAction func restart(sender: UIButton) {
        gamecount = gamecount + 1
        //make shuffle after five games
        if(gamecount == 5){
            blackjack.shoe.decks[blackjack.currentDeck].shuffle()
            blackjack.shoe = Shoe(number: numDecks)
            gamecount = 0;
            
        }
        
        restartButtor.hidden = true
        dealButton.hidden = false
        for x in blackjack.players {x.stand = false}
        
        //revised
        for i in 0..<blackjack.players.count {for x in 0..<blackjack.players[i].cards.count {pLabels[i][x].text = nil}}
        for i in 0..<2 {dlLabels[i].text = nil}
        dlScore.text = nil
        
        //revised
        pLabels.removeAll(keepCapacity: false)
        dlLabels.removeAll(keepCapacity: false)
        
        for x in blackjack.players{x.cards.removeAll(keepCapacity: false)}
        blackjack.dealer.cards.removeAll(keepCapacity: false)
        
        plLabels += [plCardOne, plCardTwo, plCardThree, plCardFour, plCardFive, plCardSix]
        dlLabels += [dlCardOne, dlCardTwo]
        pLabels += [plLabels, pl1Labels]

        blackjack.currentDeck = 0;
        
    }
    
    func refresh(){
        //revised
        for i in 0..<blackjack.players.count{for a in 0..<blackjack.players[i].cards.count {
            pLabels[i][a].text = blackjack.players[i].cards[a].cd
            plScores[i].text = blackjack.players[i].checkScore().strScore
            }}
        
        for b in 0..<blackjack.dealer.cards.count {
            dlLabels[b].text = blackjack.dealer.cards[b].cd
        }
    }
    
    func checkScore(playerScore:Int, dealerScore:Int, index:Int) -> String {
        if playerScore > 21 {
            //blackjack.players[blackjack.currentPlayer].amount -= plBets[blackjack.currentPlayer].text.toInt()!
            return ("Over 21, you lost!")
            
        }
        if dealerScore > 21  {
            blackjack.players[index].amount += plBets[index].text.toInt()!*2
            return ("Dealer sucks, you won!")
        }
        if dealerScore == 21 && playerScore != 21 {
            //blackjack.players[blackjack.currentPlayer].amount -= plBets[blackjack.currentPlayer].text.toInt()!
            return ("Dealer has BlackJack, you lost!")
        }
        if (playerScore == 21 && dealerScore != 21) {
            blackjack.players[index].amount += plBets[index].text.toInt()!*2
            return ("BlackJack, you won!")
        }
        if (playerScore > dealerScore) {
            blackjack.players[index].amount += plBets[index].text.toInt()!*2
            return ("You Won")
        }
        if dealerScore > playerScore {
            //blackjack.players[blackjack.currentPlayer].amount -= plBets[blackjack.currentPlayer].text.toInt()!
            return ("House Won")
        }
       blackjack.players[index].amount += plBets[index].text.toInt()!
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
        //revised
        for i in 0..<blackjack.players.count{if (blackjack.players[i].stand == true) {stand_ = stand_ + 1}}
        
        //if all plays stood, code below gets executed
        if (stand_ == blackjack.players.count) {
            dlLabels[0].text = blackjack.dealer.unhide()?.cd
            hitButton.hidden = true;standButton.hidden = true
            while (blackjack.dealer.checkScore("s").intScore < 16) {blackjack.dealer.addCard(blackjack.getCard(blackjack.currentDeck)!)}
            //for x in 0..<plLabels.count {plLabels[x].text = nil}
            //for i in 0..<dlLabels.count {dlLabels[i].text = nil}
            for i in 0..<blackjack.players.count {blackjack.players[i].amount -= plBets[i].text.toInt()!}
            var str = blackjack.dealer.checkScore().intScore
            dlScore.text = "\(str)"
            for i in 0..<blackjack.players.count {plScores[i].text = checkScore(blackjack.players[i].checkScore().intScore, dealerScore: blackjack.dealer.checkScore("a").intScore, index: i)}
            
            for i in 0..<blackjack.players.count {
                var tmp:Int = blackjack.players[i].amount
                plSums[i].text = "\(tmp)"
            }
            
            restartButtor.hidden = false

            if(blackjack.players[blackjack.currentPlayer].amount < 1){
                blackjack.players.removeAtIndex(blackjack.currentPlayer)
                if(++blackjack.isOut >= blackjack.players.count){
            let alertController = UIAlertController(title: "BlackJack", message:
                "GAME OVER!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Restart", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
                
                for i in 0..<numPlayers {for x in 0..<6 {pLabels[i][x].text = nil}}
                for i in 0..<2 {dlLabels[i].text = nil}
                dlScore.text = nil
                
                //revised
                pLabels.removeAll(keepCapacity: false)
                dlLabels.removeAll(keepCapacity: false)
                    for i in 0..<plBets.count {plBets[i].text = "0"}
                for x in blackjack.players{x.cards.removeAll(keepCapacity: false)}
                blackjack.dealer.cards.removeAll(keepCapacity: false)
                restartButtor.hidden = true
                hitButton.hidden = false
                standButton.hidden = false
            viewDidLoad()
                }
            
            }
            return
        }
        plSums[blackjack.currentPlayer].text = "\(blackjack.players[blackjack.currentPlayer].amount)"
        var temp:Int = blackjack.players[blackjack.currentPlayer].amount - plBets[blackjack.currentPlayer].text.toInt()!
        plSums[blackjack.currentPlayer].text = "\(temp)"
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        plLabels += [plCardOne, plCardTwo, plCardThree, plCardFour, plCardFive, plCardSix]
        pl1Labels += [pl1CardOne, pl1CardTwo, pl1CardThree, pl1CardFour, pl1CardFive, pl1CardSix]
        pLabels += [plLabels, pl1Labels]
        dlLabels += [dlCardOne, dlCardTwo]
        plScores += [plScore, pl1Score]
        plBets += [plBet, pl1Bet]
        plSums += [plSum, pl1Sum]
        blackjack = Game(deckSize: numDecks,playerNumber: numPlayers)
        for i in 0..<blackjack.players.count {plSums[i].text = "\(blackjack.players[i].amount)"}
        getPlayerStats()
        isstart = true
        dealButton.hidden = true
        restartButtor.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

