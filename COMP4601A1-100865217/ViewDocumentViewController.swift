//
//  ViewDocumentViewController.swift
//  COMP4601A1-100865217
//
//  Created by John Marsh on 2015-01-26.
//  Copyright (c) 2015 John Marsh. All rights reserved.
//

import UIKit

class ViewDocumentViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!
    @IBOutlet var documentTitle: UILabel!
    
    var document : Document!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // documentTitle.text = document.name;
    }
    
    override func viewDidAppear(animated: Bool) {
        webView.loadRequest(NSMutableURLRequest(URL: NSURL(string: SDANetworkManager.sharedInstance().serviceURL+"/"+document.id)!))
    }
   
    @IBAction func didPressBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editDocument") {
            let viewController: CreateDocumentViewController = segue.destinationViewController as CreateDocumentViewController;
            viewController.document = document
        }
    }
}
