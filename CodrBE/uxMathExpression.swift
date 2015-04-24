//
//  uxMathExpression.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class uxMathExpression: uxExpression
{
    var op:String!
    var lrand:uxExpression!
    var rrand:uxExpression!
    
    override func toJSON() -> String
    {
        return "{\"type\":\"math-exp\",\"op\":\"\(self.op)\",\"left\":\"\(self.lrand)\",\"right\":\"\(self.rrand)\"}"
    }
    
    override func displayValue() -> String
    {
        return self.lrand.displayValue() + " " + self.op + " " + self.rrand.displayValue()
    }
}

