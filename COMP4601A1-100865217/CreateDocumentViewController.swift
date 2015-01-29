//
//  CreateDocumentViewController.swift
//  COMP4601A1-100865217
//
//  Created by John Marsh on 2015-01-26.
//  Copyright (c) 2015 John Marsh. All rights reserved.
//

import UIKit

class CreateDocumentViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var textTextField: UITextView!
    @IBOutlet var tagsTextField: UITextField!
    @IBOutlet var linksTextField: UITextView!
    
    var document : Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameTextField.text = document?.name ?? ""
        textTextField.text = document?.text ?? ""
        if(document != nil){
            var tagString : NSMutableString = NSMutableString()
            var linkString : NSMutableString = NSMutableString()
            for tag in document!.tags {
                tagString.appendString("\(tag),")
            }
            tagsTextField.text =  tagString.substringToIndex(tagString.length-1)
            for link in document!.links{
                 linkString.appendString("\(link),")
            }
            linksTextField.text =  linkString.substringToIndex(linkString.length-1)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPressSubmit(sender: AnyObject) {
        var docDic : NSMutableDictionary = NSMutableDictionary()
        if(document != nil){
            docDic.setObject(document!.id, forKey: "id")
        }
        docDic.setObject(nameTextField.text, forKey: "name")
        docDic.setObject(textTextField.text, forKey: "text")
        docDic.setObject(tagsTextField.text, forKey: "tags")
        docDic.setObject(linksTextField.text, forKey: "links")
        SDANetworkManager.sharedInstance().createDocument(docDic, completionHandler: {(data, response, error) -> Void in
            var httpResponse : NSHTTPURLResponse =  response as NSHTTPURLResponse;
            var statusCode = httpResponse.statusCode;
            if(statusCode == 200){
                dispatch_async(dispatch_get_main_queue(), {
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else{
                var alert : UIAlertView = UIAlertView(title: "Document Creation Failed", message: httpResponse.description, delegate: nil, cancelButtonTitle: "OK")
                dispatch_async(dispatch_get_main_queue(), {
                    alert.show()
                })
            }
        })
    }
    

    @IBAction func didPressCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
