//
//  uxPrintStatement.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class uxPrintStatement: uxStatement
{
    var value : uxExpression!
    
    override func toJSON() -> String
    {
        return "{\"type\":\"print\",\"value\":\(self.value.toJSON())}"
    }
    
    override func displayValue() -> String
    {
        return "Print \(self.value.displayValue())"
    }
}
