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
    
    func run() -> String
    {
        var numberOfStatements = json["statements"].count
        var result = ""
        for i in 0..<numberOfStatements
        {
            if(json["statements"][i]["type"] == "remember")
            {
                //**Check to make sure Remember does not already exist
                var exprResult = self.processExpression(json["statements"][i]["value"])
                self.env.addRemember(json["statements"][i]["name"].stringValue, value:exprResult)
            }
            else if(json["statements"][i]["type"] == "remember-set")
            {
                var exprResult = self.processExpression(json["statements"][i]["value"])
                println(exprResult)
                self.env.updateRemember(json["statements"][i]["name"].stringValue, newValue: exprResult)
            }
            else if(json["statements"][i]["type"] == "print")
            {
                var exprResult = self.processExpression(json["statements"][i]["value"])
                if(count(result) == 0)
                {
                    result = exprResult
                }
                else
                {
                    result = result + "\n\(exprResult)"
                }
            }
            else if(json["statements"][i]["type"] == "repeat-loop")
            {
                var exprResult = self.processExpression(json["statements"][i]["body"])
                //build loop output
                var loopOutput = ""
                var iterations =
                for(var i = 0; i < iterations; i++)
                {
                    if(count(loopOutput) == 0)
                    {
                        loopOutput = exprResult
                    }
                    else
                    {
                        loopOutput = loopOutput + "\n\(exprResult)"
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
        }
        return result

    }
}
