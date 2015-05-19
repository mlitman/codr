//
//  boolExpr.swift
//  CodrBE
//
//  Created by Michael Litman on 4/18/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class boolExpr: expression
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
    
    func isValidArithmeticOperator(op: String) -> Bool
    {
        return op == "<" || op == ">" || op == "<=" || op == ">=" || op == "==" || op == "!="
    }
    
    func isValidLogicalOperator(op: String) -> Bool
    {
        return op == "||" || op == "&&" || op == "!"
    }

    override func resolve(env : variableEnv) -> String
    {
        if(self.isValidArithmeticOperator(self.op))
        {
            return self.applyArithmeticExpression(env)
        }
        else
        {
            return self.applyLogicalExpression(env)
        }
    }

    func applyLogicalExpression(env : variableEnv) -> String
    {
        var answer : Bool!
        var lv = true
        if(self.leftVal=="false")
        {
            lv = false
        }
        var rv = true
        if(self.rightVal=="false")
        {
            rv = false
        }
        
        if(op == "or")
        {
            answer = lv || rv
        }
        else if(op == "and")
        {
            answer = lv && rv
        }
        else if(op == "not")
        {
            answer = !rv
        }
        return "\(answer)"
        
    }
    
    func applyArithmeticExpression(env : variableEnv) -> String
    {
        var answer : Bool!
        if(op == "<")
        {
            answer = self.leftVal.toInt()! < self.rightVal.toInt()!
        }
        else if(op == "<=")
        {
            answer = self.leftVal.toInt()! <= self.rightVal.toInt()!
        }
        else if(op == ">")
        {
            answer = self.leftVal.toInt()! > self.rightVal.toInt()!
        }
        else if(op == ">=")
        {
            answer = self.leftVal.toInt()! >= self.rightVal.toInt()!
        }
        else if(op == "==")
        {
            answer = self.leftVal.toInt()! == self.rightVal.toInt()!
        }
        else if(op == "!=")
        {
            answer = self.leftVal.toInt()! != self.rightVal.toInt()!
        }
        return "\(answer)"
    }
}
