//
//  MasterViewController.swift
//  Scrambles
//
//  Created by Mandy Cho on 6/8/16.
//  Copyright © 2016 Kindness. All rights reserved.
//

import UIKit
import GameplayKit

class MasterViewController: UITableViewController {

    var objects = [String]()
    var allWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(promptForAnswer))
        if let bankPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt") {
            if let bankWords = try? String(contentsOfFile: bankPath, usedEncoding: nil) {
                allWords = bankWords.componentsSeparatedByString("\n")
            }
        }
           
        else {
            allWords = ["EmptySet"]
        }
        
        startGame()
    }

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        
        return cell
    }
    
    func startGame(){
        // Shuffling Bank
        allWords = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(allWords) as! [String]
        title = allWords[0]
       // Will keep track of user entries
        objects.removeAll(keepCapacity: true)
        //Update tableView
        tableView.reloadData()
    }
    
    func promptForAnswer(){
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .Alert)
        ac.addTextFieldWithConfigurationHandler(nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default){ [unowned self, ac] _ in
            let answer = ac.textFields![0]
            self.submitAnswer(answer.text!)
        }
        
            ac.addAction(submitAction)
            presentViewController(ac, animated: true, completion: nil)
        
    }
    
    func submitAnswer(answer: String){
        let entry = answer.lowercaseString
        
        var errorTitle: String = ""
        var errorMsg: String = ""
        
        if wordIsPossible(entry) {
            if wordIsOriginal(entry){
                if wordIsReal(entry){
                    objects.insert(answer, atIndex: 0)
                    
                    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                }
                else{
                    errorTitle = "nonexistent word"
                    errorMsg = "Your word isn't real!"
                }
            }
            else{
                errorTitle = "unoriginal"
                errorMsg = "You've already entered this one!"
            }
        }
        else{
            errorTitle = "impossible"
            errorMsg = " Sorry, your entry isn't possible"
        }

        if errorTitle != "" {
         let ac = UIAlertController(title: errorTitle, message: errorMsg, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Accept", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
        
       // let ac = UIAlertController(title: errorTitle, message: errorMsg, preferredStyle: .Alert)
      //  ac.addAction(UIAlertAction(title: "Added", style:.Default, handler: nil))
      //  presentViewController(ac, animated: true, completion: nil)
    }
    
    func wordIsPossible(entry: String) -> Bool {
        var temp = title!.lowercaseString
        
        for letter in entry.characters{
            if let position = temp.rangeOfString(String(letter)){
                temp.removeAtIndex(position.startIndex)
            }
            else{
                return false;
            }
        }
        return true;
    }
    
    func wordIsOriginal(entry: String) -> Bool {
        
        return !objects.contains(entry)
    }
    
    func wordIsReal(entry: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: entry.characters.count)
        let mispelledRange = checker.rangeOfMisspelledWordInString(entry, range: range, startingAt: 0, wrap: false, language: "en")
        
        return mispelledRange.location == NSNotFound
    }
}

