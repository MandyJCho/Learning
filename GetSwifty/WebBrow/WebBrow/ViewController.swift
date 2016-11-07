//
//  ViewController.swift
//  WebBrow
//
//  Created by Mandy Cho on 6/7/16.
//  Copyright © 2016 Kindness. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.toolbarHidden = false
        
        let url = NSURL(string: "https://\(websites[0])")!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
    
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openTapped(){
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
      
        for website in websites{
            ac.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        presentViewController(ac, animated: true, completion: nil)
    }


    func openPage(action: UIAlertAction!){
        let url = NSURL(string: "https://" + action.title!)!
        webView.loadRequest(NSURLRequest(URL:url))
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        // url holds the NSURL of the current navigation
        let url = navigationAction.request.URL
        
        // Checks to see if the domain name is in the current url
        if let host = url!.host {
            for website in websites {
                if host.rangeOfString(website) != nil {
                    decisionHandler(.Allow)
                    print("Allowed \(url)")
                    return
                }
            }
        }
        
        decisionHandler(.Cancel)
        print("Canceled \(url)")
    }
}

