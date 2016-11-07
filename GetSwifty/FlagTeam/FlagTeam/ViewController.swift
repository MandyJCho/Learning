//
//  ViewController.swift
//  FlagTeam
//
//  Created by Mandy Cho on 6/1/16.
//  Copyright © 2016 SWITCH. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    // Flag Buttons
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    
    // Variables for Game
    var countries = [String]()
    var correctAnswer = 0
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Initialize the array
        countries += ["estonia", "france", "germany", "ireland", "uk", "us", "nigeria", "poland", "monaco", "italy", "russia", "spain"]
        
        // Select border color
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        // Select Border Width
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        askQuestion()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func askQuestion(sender:UIAlertAction! = nil){
        // Randomize array
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
        // Randomize correct answer
        correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        title = countries[correctAnswer].uppercaseString
        
        // Update button images
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
    }
    
    @IBAction func flagTapped(sender: UIButton) {
        // If correct
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 100
        }
        
        else{
            title = "Wrong"
        }
        
        let ac = UIAlertController(title: title, message: "The score is \(score)", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
        
        presentViewController(ac, animated: true, completion: nil )
    }


}

