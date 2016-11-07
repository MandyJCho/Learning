//
//  ViewController.swift
//  Filter
//
//  Created by Mandy Cho on 7/4/16.
//  Copyright © 2016 Obsendian. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intensitySlider: UISlider!
    
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Filter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(importImage))
        
        context = CIContext(options: nil)
        currentFilter = CIFilter(name: "CISepiaTone")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func importImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        }
        else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = possibleImage
        }
        else {
            return
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
        currentImage = newImage
        
        // Setting current image as the input image for the filter
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func changeFilter(sender: AnyObject) {
        let ac = UIAlertController(title: "Choose a Filter", message: nil, preferredStyle: .ActionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .Default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func setFilter(action: UIAlertAction){
        currentFilter = CIFilter(name: action.title!)
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(ViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @IBAction func intensityChanged(sender: AnyObject) {
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensitySlider.value, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensitySlider.value * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensitySlider.value * 10, forKey: kCIInputScaleKey)
        }
        if inputKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey)
        }
        
        let cgImage = context.createCGImage(currentFilter.outputImage!, fromRect: currentFilter.outputImage!.extent)
        self.imageView.image = UIImage(CGImage: cgImage)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<Void>){
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
        else {
            let ac  = UIAlertController(title: "Save Error", message: error.debugDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(ac, animated:true, completion: nil)
            
        }
    }
}

