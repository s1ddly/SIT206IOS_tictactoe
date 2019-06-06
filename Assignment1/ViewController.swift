//
//  ViewController.swift
//  Assignment1
//
//  Created by SID SHARDANAND on 16/03/2017.
//  Copyright © 2017 SID SHARDANAND. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var startfaction = 0
    var turn = 1
    var sqaurestate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var factionstate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var notwins = 0
    var croswins = 0
    var gamepause = false
    var vsai = false
    var loopend = false
    var soundPlayer: AVAudioPlayer?
    var elapsedTime : TimeInterval = 0
    var squarepointer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let path = Bundle.main.path(forResource: "song1", ofType: "mp3")
        
        let url = Bundle.main.url(forResource: "song1", withExtension: "mp3")
        
        do {
            try soundPlayer = AVAudioPlayer(contentsOf: url!)
        }
        catch{print("audiofile not available")}
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var naughtwincounter: UILabel!
    
    @IBOutlet weak var crosswincounter: UILabel!
    
    @IBAction func playmusc(_ sender: UIButton)
    {
        if soundPlayer != nil
        {
            soundPlayer!.currentTime = elapsedTime
            soundPlayer!.play()
        }
    }
    
    
    @IBAction func pausmusc(_ sender: UIButton)
    {
        if soundPlayer != nil
        {
            soundPlayer!.currentTime = elapsedTime
            soundPlayer!.pause()
        }
    }
    
    @IBAction func aiselect(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0)
        {
            vsai = false
        } else {
            vsai = true
        }
        var i = 0
        while (i <= sqaurestate.count)
        {
            let button = self.view.viewWithTag(i) as? UIButton
            button?.setImage(UIImage(named: "nil"), for: .normal)
            i = i + 1
        }
        turn = 1
        gamepause = false
        sqaurestate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        factionstate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
    
    @IBAction func pausebutton(_ sender: UIButton)
    {
        if (gamepause == false)
        {
            gamepause = true
        } else {
            gamepause = false
        }
    }
    
    @IBAction func newgame(_ sender: UIButton)
    {
        var i = 0
        while (i <= sqaurestate.count)
        {
            let button = self.view.viewWithTag(i) as? UIButton
            button?.setImage(UIImage(named: "nil"), for: .normal)
            i = i + 1
        }
        turn = 1
        sqaurestate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        factionstate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gamepause = false
        notwins = 0
        croswins = 0
        naughtwincounter.text = "\(notwins)"
        crosswincounter.text = "\(croswins)"
    }
    
    @IBAction func restart(_ sender: UIButton)
    {
        var i = 0
        while (i <= sqaurestate.count)
        {
            let button = self.view.viewWithTag(i) as? UIButton
            button?.setImage(UIImage(named: "nil"), for: .normal)
            i = i + 1
        }
        turn = 1
        sqaurestate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        factionstate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gamepause = false
        naughtwincounter.text = "\(notwins)"
        crosswincounter.text = "\(croswins)"
    }
    
    @IBAction func Factionselect(_ sender: UISegmentedControl)
    {
        if (sender.selectedSegmentIndex == 0)
        {
            startfaction = 0
        } else {
            startfaction = 1
        }
        var i = 0
        while (i <= sqaurestate.count)
        {
            let button = self.view.viewWithTag(i) as? UIButton
            button?.setImage(UIImage(named: "nil"), for: .normal)
            i = i + 1
        }
        turn = 1
        gamepause = false
        sqaurestate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        factionstate = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }
    
    @IBAction func gamesquare(_ sender: UIButton)
    {
        if (gamepause == false)
        {
            switch startfaction
            {
            case 0:
                if (sqaurestate[sender.tag - 1] == 0){
                    
                    if (turn % 2 != 0)
                    {
                        sender.setImage(UIImage(named: "not"), for: .normal)
                        factionstate[sender.tag - 1] = 2
                    } else {
                        sender.setImage(UIImage(named: "cros"), for: .normal)
                        factionstate[sender.tag - 1] = 1
                    }
                    sqaurestate[sender.tag - 1] = sender.tag
                    turn += 1
                }
            case 1:
                if (sqaurestate[sender.tag - 1] == 0){
                    if (turn % 2 == 0)
                    {
                        sender.setImage(UIImage(named: "not"), for: .normal)
                        factionstate[sender.tag - 1] = 2
                    } else {
                        sender.setImage(UIImage(named: "cros"),  for: .normal)
                        factionstate[sender.tag - 1] = 1
                    }
                    sqaurestate[sender.tag - 1] = sender.tag
                    turn += 1
                }
            default:
                break
            }
            
            if (vsai == true)
            {
                var loopcount = 0
                switch startfaction
                {
                case 0:
                    loopcount = 0
                    var foundsquare = false
                    while(foundsquare == false)
                    {
                        squarepointer = Int(arc4random_uniform(10))
                        loopcount += 1
                        
                        if (squarepointer != 0 && factionstate[squarepointer - 1] == 0)
                        {
                            let aibutton = self.view.viewWithTag(squarepointer) as? UIButton
                            aibutton?.setImage(UIImage(named: "cros"), for: .normal)
                            factionstate[squarepointer - 1] = 1
                            sqaurestate[squarepointer - 1] = squarepointer
                            foundsquare = true
                            turn += 1
                        }
                        
                        if (loopcount >= 200)
                        {
                            foundsquare = true
                        }
                    }
                case 1:
                    loopcount = 0
                    var foundsquare = false
                    while(foundsquare == false)
                    {
                        squarepointer = Int(arc4random_uniform(10))
                        loopcount += 1
                        
                        if (squarepointer != 0 && factionstate[squarepointer - 1] == 0)
                        {
                            let aibutton = self.view.viewWithTag(squarepointer) as? UIButton
                            aibutton?.setImage(UIImage(named: "not"), for: .normal)
                            factionstate[squarepointer - 1] = 2
                            sqaurestate[squarepointer - 1] = squarepointer
                            foundsquare = true
                            turn += 1
                        }
                        
                        if (loopcount >= 200)
                        {
                            foundsquare = true
                        }
                    }
                default:
                    break
                }
            }
            
            if (factionstate[0] == 1 && factionstate[1] == 1 && factionstate[2] == 1)
            {
                let winalert = UIAlertController(title: "Cross Wins!", message: "3 in a row on the top!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                croswins += 1
            }
            if (factionstate[3] == 1 && factionstate[4] == 1 && factionstate[5] == 1)
            {
                let winalert = UIAlertController(title: "Cross Wins!", message: "3 in a row in the middle!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                croswins += 1
            }
            if (factionstate[6] == 1 && factionstate[7] == 1 && factionstate[8] == 1)
            {
                let winalert = UIAlertController(title: "Cross Wins!", message: "3 in a row on the bottom!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                croswins += 1
            }
            if ((factionstate[0] == 1 && factionstate[4] == 1 && factionstate[8] == 1) || (factionstate[2] == 1 && factionstate[4] == 1 && factionstate[6] == 1))
            {
                let winalert = UIAlertController(title: "Cross Wins!", message: "3 in a row diagonally!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                croswins += 1
            }
            if (factionstate[0] == 1 && factionstate[3] == 1 && factionstate[6] == 1)
            {
                let winalert = UIAlertController(title: "Cross Wins!", message: "3 in a column on the left!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                croswins += 1
            }
            if (factionstate[1] == 1 && factionstate[4] == 1 && factionstate[7] == 1)
            {
                let winalert = UIAlertController(title: "Cross Wins!", message: "3 in a column in he middle!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                croswins += 1
            }
            if (factionstate[2] == 1 && factionstate[5] == 1 && factionstate[8] == 1)
            {
                let winalert = UIAlertController(title: "Cross Wins!", message: "3 in a column on the right!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                croswins += 1
            }
            
            if (factionstate[0] == 2 && factionstate[1] == 2 && factionstate[2] == 2)
            {
                let winalert = UIAlertController(title: "Naught Wins!", message: "3 in a row on the top!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                notwins += 1
            }
            if (factionstate[3] == 2 && factionstate[4] == 2 && factionstate[5] == 2)
            {
                let winalert = UIAlertController(title: "Naught Wins!", message: "3 in a row in the middle!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                notwins += 1
            }
            if (factionstate[6] == 2 && factionstate[7] == 2 && factionstate[8] == 2)
            {
                let winalert = UIAlertController(title: "Naught Wins!", message: "3 in a row on the bottom!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                notwins += 1
            }
            if ((factionstate[0] == 2 && factionstate[4] == 2 && factionstate[8] == 2) || (factionstate[2] == 2 && factionstate[4] == 2 && factionstate[6] == 2))
            {
                let winalert = UIAlertController(title: "Naught Wins!", message: "3 in a row diagonally!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                notwins += 1
            }
            if (factionstate[0] == 2 && factionstate[3] == 2 && factionstate[6] == 2)
            {
                let winalert = UIAlertController(title: "Naught Wins!", message: "3 in a column on the left!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                notwins += 1
            }
            if (factionstate[1] == 2 && factionstate[4] == 2 && factionstate[7] == 2)
            {
                let winalert = UIAlertController(title: "Naught Wins!", message: "3 in a column in the middle!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                notwins += 1
            }
            if (factionstate[2] == 2 && factionstate[5] == 2 && factionstate[8] == 2)
            {
                let winalert = UIAlertController(title: "Naught Wins!", message: "3 in a row on the right!", preferredStyle: UIAlertControllerStyle.alert)
                winalert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(winalert, animated: true, completion: nil)
                gamepause = true
                notwins += 1
            }
            
            if (sqaurestate == [1, 2, 3, 4, 5, 6, 7, 8, 9])
            {
                let tiealert = UIAlertController(title: "Tie!", message: "No more available moves!", preferredStyle: UIAlertControllerStyle.alert)
                tiealert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                self.present(tiealert, animated: true, completion: nil)
                gamepause = true
            }
            
        }
        
        naughtwincounter.text = "\(notwins)"
        crosswincounter.text = "\(croswins)"
    }
}
