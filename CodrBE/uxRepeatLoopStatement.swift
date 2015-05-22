//
//  uxLoopStatement.swift
//  CodrBE
//
//  Created by Michael Litman on 5/15/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class uxRepeatLoopStatement: uxStatement
{
    var numberOfTimes : uxExpression!
    var body : uxStatement!
    
    override func toJSON() -> String
    {
        return "{\"type\":\"repeat-loop\",\"times\":\(self.numberOfTimes.toJSON()),\"body\":\(self.body.toJSON())}"
    }
    
    override func displayValue() -> String
    {
        return "Repeat (\(self.body.displayValue())) -> \(self.numberOfTimes.displayValue()) times"
    }
}
