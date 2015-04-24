//
//  uxRememberStatement.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class uxRememberStatement: uxStatement
{
    var name : String!
    var value : uxExpression!
    
    init(name : String)
    {
        self.name = name
    }
    
    override func toJSON() -> String
    {
        return "{\"type\":\"remember\",\"name\":\"\(self.name)\",\"value\":\(self.value.toJSON())}"
    }
    
    override func displayValue() -> String
    {
        return "Remember \(self.name) = \(self.value.displayValue())"
    }
}
