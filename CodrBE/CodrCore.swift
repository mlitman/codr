//
//  CodrCore.swift
//  CodrBE
//
//  Created by Michael Litman on 5/4/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class CodrCore: NSObject
{
    static var theProgram = [uxStatement]()
    static var statements = [uxStatement]()
    static var expressions = [uxExpression]()
    static var theToolBox : [String] = ["Create Remember","Change Remember","Print"]
    static var theExpressionTypes : [String] = ["Literal","Remember","Math","Boolean"]
    static var theMathOps = ["+","-","*","/"]
    
    static func getRememberStatements() -> [uxRememberStatement]
    {
        var theRemembers = [uxRememberStatement]()
        for stmt in CodrCore.theProgram
        {
            if(stmt is uxRememberStatement)
            {
                theRemembers.append(stmt as! uxRememberStatement)
            }
        }
        return theRemembers
    }
    
    static func addStatementToProgram(var stmt : uxStatement)
    {
        CodrCore.theProgram.append(stmt)
    }
    
    static func popStatement() -> uxStatement
    {
        return CodrCore.statements.removeLast()
    }
    
    static func pushStatement(var stmt: uxStatement)
    {
        CodrCore.statements.append(stmt)
    }

    static func popExpression() -> uxExpression
    {
        return CodrCore.expressions.removeLast()
    }

    static func pushExpression(var expr : uxExpression)
    {
        CodrCore.expressions.append(expr)
    }

}
