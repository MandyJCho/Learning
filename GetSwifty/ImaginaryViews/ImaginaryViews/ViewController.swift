//
//  ViewController.swift
//  ImaginaryViews
//
//  Created by Mandy Cho on 6/15/16.
//  Copyright © 2016 Obsendian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.redColor()
        view.addSubview(label1)
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.orangeColor()
        view.addSubview(label2)

        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellowColor()
        view.addSubview(label3)
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.greenColor()
        view.addSubview(label4)
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.blueColor()
        view.addSubview(label5)
        
        let label6 = UILabel()
        label6.translatesAutoresizingMaskIntoConstraints = false
        label6.backgroundColor = UIColor.purpleColor()
        view.addSubview(label6)
        
        let colors = ["red" : label1, "orange" : label2, "yellow" : label3, "green" : label4, "blue" : label5, "violet" :label6]
        
        for color in colors.keys {
            view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[\(color)]|", options: [], metrics: nil, views: colors))
        }
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=30)-[red(labelHeight)]-[orange(labelHeight)]-[yellow(labelHeight)]-[green(labelHeight)]-[blue(labelHeight)]-[violet(labelHeight)]-(>=55)-|", options: [.AlignAllCenterX], metrics: ["labelHeight": 50], views: colors))
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

