//
//  mathExpr.swift
//  CodrBE
//
//  Created by Michael Litman on 4/18/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class mathExpr: expression
{
    var op:String!
    var leftVal:String!
    var rightVal:String!
    
    init(op: String, leftVal: String, rightVal: String)
    {
        self.op = op;
        self.leftVal = leftVal
        self.rightVal = rightVal
    }
    
    static func isValidOperator(op: String) -> Bool
    {
        return op == "+" || op == "-" || op == "*" || op == "/"
    }
    
    func applyExpression(env : variableEnv) -> String
    {
        var answer : Int!
        if(op == "+")
        {
            print("Calc: \(self.leftVal.toInt()) + \(self.rightVal.toInt())")
            answer = self.leftVal.toInt()! + self.rightVal.toInt()!
        }
        else if(op == "-")
        {
            answer = self.leftVal.toInt()! - self.rightVal.toInt()!
        }
        else if(op == "*")
        {
            answer = self.leftVal.toInt()! * self.rightVal.toInt()!
        }
        else if(op == "/")
        {
            answer = self.leftVal.toInt()! / self.rightVal.toInt()!
        }
        return "\(answer)";
    }
    
    override func resolve(env : variableEnv) -> String
    {
        return self.applyExpression(env)
    }
}
