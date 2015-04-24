//
//  varExpr.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class varExpr: expression
{
    var name:String!
    
    init(name: String)
    {
        self.name = name
    }

    override func resolve(env : variableEnv) -> String
    {
        return env.resolveRemember(self.name)
    }
}
