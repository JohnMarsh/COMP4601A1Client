//
//  DocumentXMLParser.swift
//  COMP4601A1-100865217
//
//  Created by John Marsh on 2015-01-25.
//  Copyright (c) 2015 John Marsh. All rights reserved.
//

import UIKit

private let _instance = DocumentXMLParser();

class DocumentXMLParser: NSObject, NSXMLParserDelegate {
    
    var parser : NSXMLParser
    var documents : NSMutableArray
    var document : Document?
    var element : NSString?
    
    func parseData(xml : NSData!, onComplete : ((NSMutableArray!, NSError?) -> Void)!){
        parser = NSXMLParser(data: xml)
        parser.delegate = self
        documents = NSMutableArray();
        if(parser.parse()){
            onComplete(documents, nil)
        }else{
            onComplete(documents, NSError())
        }
    }
    
    override init(){
        parser = NSXMLParser();
        documents = NSMutableArray();
    }
    
    class func sharedInstance() -> DocumentXMLParser{
        return _instance;
    }
    
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!){
        println("Found tag: \(elementName)")
        if(elementName == "documents" || elementName == "document"){
            document = Document();
        } else if(elementName == "documentCollection"){
             documents = NSMutableArray();
        }
        
    }
    
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!){
         println("Ended tag: \(elementName)")
        
        switch(elementName){
            case "id" :
                document?.id = element
                break;
            case "name":
                document?.name = element
                break;
            case "text":
                document?.text = element
                break;
            case "tags":
                document?.tags.addObject(element!)
                break;
            case "tag":
                document?.tags.addObject(element!)
                break;
            case "links":
                document?.links.addObject(element!)
                break;
            case "link":
                document?.links.addObject(element!)
                break;
            case "documents":
                documents.addObject(document!)
                break;
            case "document":
                documents.addObject(document!)
                break;
            default:
                break;
        }
        
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!){
        println("Found value: \(string)")
        element = string;
    }
   
   
}
