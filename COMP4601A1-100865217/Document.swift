//
//  Document.swift
//  COMP4601A1-100865217
//
//  Created by John Marsh on 2015-01-26.
//  Copyright (c) 2015 John Marsh. All rights reserved.
//

import UIKit

class Document: NSObject {
    
    var id : NSString!;
    var name : NSString!;
    var text : NSString!;
    var tags : NSMutableArray!;
    var links : NSMutableArray!;
    
    
    override init(){
        tags = NSMutableArray();
        links = NSMutableArray();
        super.init();
    }
    
    convenience init(id : NSString!,  name : NSString!, text : NSString!){
        self.init();
        self.id = id;
        self.name = name;
        self.text = text;
    }

   
}
