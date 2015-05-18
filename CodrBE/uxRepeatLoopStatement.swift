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
    var numberOfTimes : Int!
    
    override func toJSON() -> String
    {
        return "{\"type\":\"repeat-loop\",\"times\":\(self.numberOfTimes),\"body\":\(self.value.toJSON())}"
    }
    
    override func displayValue() -> String
    {
        return "Loop \(self.value.displayValue()) times"
    }
}