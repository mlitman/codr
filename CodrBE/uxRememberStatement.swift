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
    var name = ""
    
    override func toJSON() -> String
    {
        return "{\"type\":\"remember\",\"name\":\"\(self.name)\",\"value\":\(self.value.toJSON())}"
    }
    func listDisplayValue() -> String
    {
        return self.name
    }
    
    override func displayValue() -> String
    {
        return "Remember \(self.name) = \(self.value.displayValue())"
    }
}
