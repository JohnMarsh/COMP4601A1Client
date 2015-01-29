//
//  SDANetworkManager.swift
//  COMP4601A1-100865217
//
//  Created by John Marsh on 2015-01-25.
//  Copyright (c) 2015 John Marsh. All rights reserved.
//

import UIKit

//protocol SDANetworkManagerDelegate{
//    func didFindDocumentWithId;
//    func didDeleteDocumentWithId;
//    func didFindDocumentsWithTags;
//    func didPutOrUpdateDocument;
//}


private let _instance = SDANetworkManager();

class SDANetworkManager: NSObject {
    
    let serviceURL : NSString! = "http://localhost:8080/COMP4601SDA/rest/sda";
    let getAllDocumentsURL : NSString! = "http://localhost:8080/COMP4601SDA/rest/sda/documents"
    let serviceSearchURL : NSString! = "http://localhost:8080/COMP4601SDA/rest/sda/search";
    
    class func sharedInstance() -> SDANetworkManager{
        return _instance;
    }
    
    func getAllDocuments( completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!){
        var request = NSMutableURLRequest(URL: NSURL(string: getAllDocumentsURL)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        var task = session.dataTaskWithRequest(request, completionHandler);
        task.resume()
    }
    
    
    func getDocumentWithId(id : NSString!, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!){
        var request = NSMutableURLRequest(URL: NSURL(string: serviceURL+"/"+id)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler);
        task.resume()
    }
    
    func deleteDocumentWithId(id : NSString!, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!){
        var request = NSMutableURLRequest(URL: NSURL(string: serviceURL+"/"+id)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "DELETE"
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        var task = session.dataTaskWithRequest(request, completionHandler)
        task.resume()
        
    }
    
    func deleteDocumentsWithTags(tags: NSArray, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!){
        if(tags.count == 0){
            return;
        }
        
        var deleteUrl = NSString(string: serviceURL+"/delete/");
        
        for tag in tags{
            deleteUrl = deleteUrl + "\(tag):";
        }
        
        deleteUrl = deleteUrl.substringToIndex(deleteUrl.length-1);
        
        var request = NSMutableURLRequest(URL: NSURL(string: deleteUrl)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        
        var task = session.dataTaskWithRequest(request, completionHandler);
        task.resume()
    }
    
    func searchForDocumentWithTags(tags: NSArray, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!){
        
        if(tags.count == 0){
            return;
        }
        
        var searchUrl = NSString(string: serviceSearchURL+"/");
        
        for tag in tags{
            searchUrl = searchUrl + "\(tag):";
        }
        
        searchUrl = searchUrl.substringToIndex(searchUrl.length-1);
        
        var request = NSMutableURLRequest(URL: NSURL(string: searchUrl)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        request.addValue("application/xml", forHTTPHeaderField: "Accept")
        
        
        var task = session.dataTaskWithRequest(request, completionHandler);
        task.resume()
    }
    
    func createDocument(contents : NSMutableDictionary, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!){
        
        var keys : NSArray = contents.allKeys;
        
        var formString = "";
        
        for key in keys{
            formString += "\(key)=\(contents.objectForKey(key)!.description)"
            if(keys.indexOfObject(key) != keys.count-1){
                formString += "&";
            }
        }
        
        var request = NSMutableURLRequest(URL: NSURL(string: serviceURL)!);
        var session = NSURLSession.sharedSession();
        request.HTTPMethod = "POST";
        
        request.HTTPBody = formString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false);
        request.addValue("application/xml", forHTTPHeaderField: "Accept");
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type");
        
        var task = session.dataTaskWithRequest(request, completionHandler);
        task.resume()
    }
    
    func updateDocumentWithId(id :NSString!, withTags tags : NSArray, andLinks links : NSArray, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)!){
        
        var formString = "";
        formString += "tags";
        
        for tag in tags{
            formString += "\(tag)";
            if(tags.indexOfObject(tag) != tags.count-1){
                formString += ",";
            }
        }
        
        formString += "&links";
        
        for link in links{
            formString += "\(link)";
            if(links.indexOfObject(link) != links.count-1){
                formString += ",";
            }
        }
        
        var request = NSMutableURLRequest(URL: NSURL(string: serviceURL+"/"+id)!);
        var session = NSURLSession.sharedSession();
        request.HTTPMethod = "POST";
   
        request.HTTPBody = formString.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true);
        request.addValue("text/xml", forHTTPHeaderField: "Accept");
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type");
        
        var task = session.dataTaskWithRequest(request, completionHandler);
        task.resume()
    }
    
    
}
