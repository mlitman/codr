//
//  InterpreterJSON.swift
//  CodrBE
//
//  Created by Michael Litman on 4/18/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class InterpreterJSON: NSObject
{
    var json: JSON
    let env = variableEnv()
    
    init(json: JSON)
    {
        self.json = json
    }
    
    func processExpression(exp : JSON) -> String
    {
        var exprType = exp["type"]
        var theExp : expression?
        if(exprType == "lit-exp")
        {
            //process lit-expr
            theExp = litExpr(value:exp["value"].stringValue)
        }
        else if(exprType == "var-exp")
        {
            //process var-expr
            theExp = varExpr(name: exp["name"].stringValue)
        }
        else if(exprType == "arithmetic-bool-expr" || exprType == "logical-bool-expr")
        {
            print("I'm inside ABE lol")
            //process bool-expr
            if(exp["op"].stringValue == "not")
            {
                println("NOT INSIDE ABE")
                theExp = boolExpr(op:exp["op"].stringValue, leftVal:"", rightVal: self.processExpression(exp["right"]))
            }
            else
            {
                theExp = boolExpr(op:exp["op"].stringValue,leftVal: self.processExpression(exp["left"]), rightVal: self.processExpression(exp["right"]))
            }
        }
        else if(exprType == "math-exp")
        {
            //process Math Expr
            theExp = mathExpr(op:exp["op"].stringValue,leftVal: self.processExpression(exp["left"]), rightVal: self.processExpression(exp["right"]))
        }
        return theExp!.resolve(self.env)
    }
    
    func processStatement(stmt : JSON) -> String
    {
        var result = ""
        if(stmt["type"] == "remember")
        {
            //**Check to make sure Remember does not already exist
            var exprResult = self.processExpression(stmt["value"])
            self.env.addRemember(stmt["name"].stringValue, value:exprResult)
        }
        else if(stmt["type"] == "remember-set")
        {
            var exprResult = self.processExpression(stmt["value"])
            self.env.updateRemember(stmt["name"].stringValue, newValue: exprResult)
        }
        else if(stmt["type"] == "print")
        {
            var exprResult = self.processExpression(stmt["value"])
            if(count(result) == 0)
            {
                result = exprResult
            }
            else
            {
                result = result + "\n\(exprResult)"
            }
        }
        else if(stmt["type"] == "repeat-loop")
        {
            var stmtResult : String!
            //build loop output
            var loopOutput = ""
            var iterations = self.processExpression(stmt["times"])
            for(var i = 0; i < iterations.toInt(); i++)
            {
                stmtResult = self.processStatement(stmt["body"])
                if(count(loopOutput) == 0)
                {
                    loopOutput = stmtResult
                }
                else
                {
                    loopOutput = loopOutput + "\n\(stmtResult)"
                }
            }
            
            //add the loopOutput to our program output
            if(count(result) == 0)
            {
                result = loopOutput
            }
            else
            {
                result = result + "\n\(loopOutput)"
            }
        }
        else if(stmt["type"] == "statement-collection")
        {
            var numberOfStatements = stmt["body"].count
            var collectionResult = ""
            
            for i in 0..<numberOfStatements
            {
                if(collectionResult == "")
                {
                    collectionResult = self.processStatement(stmt["body"][i])
                }
                else
                {
                    collectionResult += "\n" + self.processStatement(stmt["body"][i])
                }
            }
            result += collectionResult
        }
        return result
    }
    
    func run() -> String
    {
        return self.processStatement(json)
    }
}
