//
//  repeatLoopStmt.swift
//  CodrBE
//
//  Created by Michael Litman on 5/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class repeatLoopStmt: NSObject
{
    var iterations:String!
    var body:String!
    
    init(iterations: String, body: String)
    {
        self.iterations = iterations
        self.body = body
    }
}
