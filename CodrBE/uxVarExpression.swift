//
//  uxVarExpression.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class uxVarExpression: uxExpression
{
    var name:String!
    
    init(name: String)
    {
        self.name = name
    }
    
    override func toJSON() -> String
    {
        return "{\"type\":\"var-exp\",\"name\":\"\(self.name)\"}"
    }
    
    override func displayValue() -> String
    {
        return name!
    }

}
