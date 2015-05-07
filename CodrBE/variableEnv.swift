//
//  variableEnv.swift
//  CodrBE
//
//  Created by Michael Litman on 4/18/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class variableEnv: NSObject
{
    var env = [rememberStmt]()
    
    func hasVar(name:String) -> Bool
    {
        for remember in env
        {
            if(remember.name == name)
            {
                return true
            }
        }
        return false
    }
    
    func addRemember(name: String, value: String)
    {
        env.append(rememberStmt(name: name, value: value))
    }
    
    func updateRemember(name: String, newValue: String)
    {
        for remember in env
        {
            if(remember.name == name)
            {
                remember.value = newValue
                return
            }
        }
        //**Should never get here as long as you check that the var exists
        //before calling this!!!!!
    }
    
    func resolveRemember(name: String) -> String
    {
        println("Looking for \(name)")
        for remember in env
        {
            if(remember.name == name)
            {
                return remember.value
            }
        }
        return "NOT FOUND" //should never reach this line
    }
}
