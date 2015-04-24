//
//  litExpr.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class litExpr: expression
{
    var value:String!
    
    init(value: String)
    {
        self.value = value
    }
    
    override func resolve(env : variableEnv) -> String
    {
        return self.value
    }
}
