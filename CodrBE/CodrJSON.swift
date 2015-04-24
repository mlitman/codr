//
//  CodrJSON.swift
//  CodrBE
//
//  Created by Michael Litman on 4/18/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class CodrJSON: NSObject
{
    var theJSONstring : String!
    var theTextView : UITextView!
    
    init(theJSONstring: String, theTextView: UITextView)
    {
        self.theJSONstring = theJSONstring
        self.theTextView = theTextView
        //do our parsing
    }
    
    func interpretJSON() -> Void
    {
        
        let data = (self.theJSONstring as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let json = JSON(data: data!)
        
        let theInterpreter = InterpreterJSON(json: json)
        
        var result = theInterpreter.run()
        self.theTextView.text = result
    }
    
    func display() -> Void
    {
        self.interpretJSON()
        
    }
}

