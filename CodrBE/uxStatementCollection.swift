//
//  uxStatementCollection.swift
//  CodrBE
//
//  Created by Michael Litman on 5/25/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class uxStatementCollection: uxStatement
{
    var theCollection = [uxStatement]()
    
    func popStatement() -> uxStatement
    {
        return self.theCollection.removeLast()
    }
    
    func pushStatement(var stmt: uxStatement)
    {
        self.theCollection.append(stmt)
    }

    override func toJSON() -> String
    {
        var output = "{\"type\":\"statement-collection\",\"body\":["
        for stmt in self.theCollection
        {
            if(output == "{\"type\":\"statement-collection\",\"body\":[")
            {
                output += stmt.toJSON()
            }
            else
            {
                output += "," + stmt.toJSON()
            }
        }
        output += "]}"
        return output
    }
    
    override func displayValue() -> String
    {
        return "Statement Collection"
    }
}
