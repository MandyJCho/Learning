//
//  ViewController.swift
//  Wordsmith
//
//  Created by Mandy Cho on 6/17/16.
//  Copyright © 2016 Obsendian. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var guess: UITextField!
    @IBOutlet weak var cluesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var level = 2
    var score: Int = 0 {
        didSet{
            scoreLabel.text! = "Score: \(score)"
        }
    }
    
    var optionButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subview in view.subviews where subview.tag == 1001 {
            let button = subview as! UIButton
            optionButtons.append(button)
            button.addTarget(self, action: #selector(letterTapped), forControlEvents: .TouchUpInside)
        }
        
        loadLevel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submitTapped(sender: AnyObject) {
        if let solutionPosition = solutions.indexOf(guess.text!) {
            activatedButtons.removeAll()
            
            score += 10
        
            var splitCluesArr = answersLabel.text!.componentsSeparatedByString("\n")
            splitCluesArr[solutionPosition] = guess.text!
            answersLabel.text! = splitCluesArr.joinWithSeparator("\n")
            
            guess.text = "Tap letters to guess"
            
            if score % 7 == 0{
                let ac = UIAlertController(title: "Well Done!", message: "You've completed the level", preferredStyle: .Alert)
               
                if level == 1 {
                    ac.addAction(UIAlertAction(title: "Next", style: .Default, handler: levelUp))
                }
                else {
                    ac.addAction(UIAlertAction(title: "Play Again", style: .Default, handler: playAgain))
                    ac.addAction(UIAlertAction(title: "Done", style: .Default, handler: nil))
                }
                
                presentViewController(ac, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func clearTapped(sender: AnyObject) {
        guess.text = "Tap letters to guess"
        
        for button in activatedButtons {
            button.hidden = false
        }
        
        activatedButtons.removeAll()
        
    }
    
    func letterTapped(button: UIButton){
        
        if (guess.text == "Tap letters to guess"){
            guess.text = ""
        }
        
        guess.text =  guess.text! + button.titleLabel!.text!
        activatedButtons.append(button)
        button.hidden = true
    }
    
    func loadLevel(){
        var clueStr = ""
        var solutionHint = ""
        var optionBits = [String]()
        
        if let levelFilePath = NSBundle.mainBundle().pathForResource("level\(level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath, usedEncoding: nil) {
                var lines = levelContents.componentsSeparatedByString("\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(lines) as! [String]
                
                for (index, line) in lines.enumerate() {
                    let parts = line.componentsSeparatedByString(": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueStr += "\(index + 1): \(clue)\n"
                    
                    let solutionWord = answer.stringByReplacingOccurrencesOfString("|", withString: "")
                    solutionHint += "\(solutionWord.characters.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.componentsSeparatedByString("|")
                    optionBits += bits
                }
            }
        }
        
        cluesLabel.text = clueStr.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        answersLabel.text = solutionHint.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
        
        optionBits = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(optionBits) as! [String]
        optionButtons = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(optionButtons) as! [UIButton]
        
        if optionBits.count == optionButtons.count {
            for i in 0 ..< optionBits.count {
              optionButtons[i].setTitle(optionBits[i], forState: .Normal)
            }
        }
    }
    
    func levelUp(action: UIAlertAction) {
        level += 1
        solutions.removeAll(keepCapacity: true)
        
        loadLevel()
        
        for button in optionButtons{
            button.hidden = false
        }
    }
    
    func playAgain(action: UIAlertAction){
        level = 0
        
        levelUp(action)
        
        loadLevel()
    }

}

