//
//  uxLoopStatement.swift
//  CodrBE
//
//  Created by Michael Litman on 5/15/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class uxLoopStatement: uxStatement
{
    var body : uxExpression!
    override func toJSON() -> String
    {
        return "{\"type\":\"loop\",\"times\":\(self.value.toJSON()),\"body\":\(self.body.toJSON())}"
    }
    
    override func displayValue() -> String
    {
        return "Loop \(self.value.displayValue()) times"
    }
}
