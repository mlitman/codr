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
        return "{\"type\":\"\(self.type)-boolean-exp\",\"op\":\"\(self.op)\",\"left\":\(self.lrand.toJSON()),\"right\":\(self.rrand.toJSON())}"
    }
    
    override func displayValue() -> String
    {
        return "(\(self.lrand.displayValue()) \(self.op) \(self.rrand.displayValue()))"
    }
}


