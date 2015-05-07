//
//  uxLitExpression.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class uxLitExpression: uxExpression
{
    var value : String
    
    override init()
    {
        self.value = ""
    }
    
    init(var value : String)
    {
        self.value = value
    }
    
    override func toJSON() -> String
    {
        return "{\"type\":\"lit-exp\",\"value\":\"\(self.value)\"}"
    }
    
    override func displayValue() -> String
    {
        return self.value
    }

}
