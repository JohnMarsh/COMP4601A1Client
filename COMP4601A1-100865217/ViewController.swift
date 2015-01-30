//
//  ViewController.swift
//  COMP4601A1-100865217
//
//  Created by John Marsh on 2015-01-25.
//  Copyright (c) 2015 John Marsh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
 
    @IBOutlet var searchByIdTextField: UITextField!
    @IBOutlet var searchByTagsTextField: UITextField!
    @IBOutlet var deleteByIdTextField: UITextField!
    @IBOutlet var deleteByTagsTextField: UITextField!


    @IBOutlet var tableView: UITableView!
    
    var documents : NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self;
        tableView.dataSource = self;
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        getAllDocuments();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func searchById(sender: AnyObject) {
        SDANetworkManager.sharedInstance().getDocumentWithId(searchByIdTextField.text, completionHandler:  { (data, response, error) -> Void in
            var httpResponse : NSHTTPURLResponse =  response as NSHTTPURLResponse;
            var statusCode = httpResponse.statusCode;
            if(statusCode == 200){
                DocumentXMLParser.sharedInstance().parseData(data, onComplete: { (array, error) -> Void in
                    if(error == nil){
                        self.documents = array
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData();
                        })
                    }
                })
            }else{
                var alert : UIAlertView = UIAlertView(title: "Document Search Failed", message: httpResponse.description, delegate: nil, cancelButtonTitle: "OK")
                dispatch_async(dispatch_get_main_queue(), {
                    alert.show()
                })
            }
            
        })
    }
    
    
    @IBAction func searchByTags(sender: AnyObject) {
        var tags : NSArray =  searchByTagsTextField.text.componentsSeparatedByString(" ");
        SDANetworkManager.sharedInstance().searchForDocumentWithTags(tags, completionHandler:  { (data, response, error) -> Void in
            var httpResponse : NSHTTPURLResponse =  response as NSHTTPURLResponse;
            var statusCode = httpResponse.statusCode;
            if(statusCode == 200){
                DocumentXMLParser.sharedInstance().parseData(data, onComplete: { (array, error) -> Void in
                    if(error == nil){
                        if(array.count == 0) {
                            var alert : UIAlertView = UIAlertView(title: "No Documentss", message: "No documents found.", delegate: nil, cancelButtonTitle: "OK")
                            dispatch_async(dispatch_get_main_queue(), {
                                alert.show()
                            })
                        }
                        self.documents = array;
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData();
                        })
                    }
                })
            }else{
                var alert : UIAlertView = UIAlertView(title: "Document Search Failed", message: httpResponse.description, delegate: nil, cancelButtonTitle: "OK")
                dispatch_async(dispatch_get_main_queue(), {
                    alert.show()
                })
            }
        })
    }
    
    
    @IBAction func deleteById(sender: AnyObject) {
        SDANetworkManager.sharedInstance().deleteDocumentWithId(deleteByIdTextField.text, completionHandler:  { (data, response, error) -> Void in
            var httpResponse : NSHTTPURLResponse =  response as NSHTTPURLResponse;
            var statusCode = httpResponse.statusCode;
            if(statusCode == 200){
                var alert : UIAlertView = UIAlertView(title: "Document Deletion Succeeded", message: httpResponse.description, delegate: nil, cancelButtonTitle: "OK")
                dispatch_async(dispatch_get_main_queue(), {
                    alert.show()
                })
            }else{
                var alert : UIAlertView = UIAlertView(title: "Document Deletion Failed", message: httpResponse.description, delegate: nil, cancelButtonTitle: "OK")
                dispatch_async(dispatch_get_main_queue(), {
                    alert.show()
                })
            }
            
        })
    }
    
   
    @IBAction func deleteByTags(sender: AnyObject) {
        var tags : NSArray =  deleteByTagsTextField.text.componentsSeparatedByString(" ");
        SDANetworkManager.sharedInstance().deleteDocumentsWithTags(tags, completionHandler:  { (data, response, error) -> Void in
            var httpResponse : NSHTTPURLResponse =  response as NSHTTPURLResponse;
            var statusCode = httpResponse.statusCode;
            if(statusCode == 200){
                var alert : UIAlertView = UIAlertView(title: "Document Deletion Succeeded", message: httpResponse.description, delegate: nil, cancelButtonTitle: "OK")
                dispatch_async(dispatch_get_main_queue(), {
                    alert.show()
                })
            }else{
                var alert : UIAlertView = UIAlertView(title: "Document Deletion Failed", message: httpResponse.description, delegate: nil, cancelButtonTitle: "OK")
                dispatch_async(dispatch_get_main_queue(), {
                    alert.show()
                })
            }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("documentCell", forIndexPath: indexPath) as UITableViewCell
        var doc = documents.objectAtIndex(indexPath.row) as Document
        cell.textLabel.text = doc.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "viewDocument") {
            let viewController: ViewDocumentViewController = segue.destinationViewController as ViewDocumentViewController;
            let doc : Document = documents.objectAtIndex(tableView.indexPathForSelectedRow()!.row) as Document
            viewController.document = doc
        } else if(segue.identifier == "createDocument"){
            let viewController: CreateDocumentViewController = segue.destinationViewController as CreateDocumentViewController;
            
        }
    }
    
    func getAllDocuments() {
        SDANetworkManager.sharedInstance().getAllDocuments({ (data, response, error) -> Void in
            var httpResponse : NSHTTPURLResponse =  response as NSHTTPURLResponse;
            var statusCode = httpResponse.statusCode;
            if(statusCode == 200){
                DocumentXMLParser.sharedInstance().parseData(data, onComplete: { (array, error) -> Void in
                    if(error == nil){
                        self.documents = array
                        dispatch_async(dispatch_get_main_queue(), {
                            self.tableView.reloadData();
                        })
                    }
                })
            }else{
                
            }
            
        })
    }
    

    @IBAction func getAllDocumentsHandler(sender: AnyObject) {
        getAllDocuments();
    }
}

