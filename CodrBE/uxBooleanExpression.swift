//
//  uxBooleanExpression.swift
//  CodrBE
//
//  Created by Michael Litman on 5/11/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class uxBooleanExpression: uxExpression
{
    var op:String!
    var type:String!
    var lrand:uxExpression!
    var rrand:uxExpression!
    
    override func toJSON() -> String
    {
        var leftVal = "\"NOT\""
        if(self.lrand != nil)
        {
            leftVal = self.lrand!.toJSON()
        }
        return "{\"type\":\"\(self.type)-bool-expr\",\"op\":\"\(self.op)\",\"left\":\(leftVal),\"right\":\(self.rrand.toJSON())}"
    }
    
    override func displayValue() -> String
    {
        var leftVal = ""
        if(self.lrand != nil)
        {
            leftVal = self.lrand!.displayValue()
        }
        return "(\(leftVal) \(self.op) \(self.rrand.displayValue()))"
    }
}


