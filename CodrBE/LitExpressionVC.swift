//
//  LitExpressionVC.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class LitExpressionVC: UIViewController
{
    var nextScreen = "NONE"
    var theStatement : uxStatement?
    var theMathExpression: uxMathExpression?

    @IBOutlet weak var litValTF: UITextField!
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(self.theStatement! is uxRememberStatement)
        {
            if(self.nextScreen == "NONE")
            {
                (self.theStatement as! uxRememberStatement).value = uxLitExpression(value: litValTF!.text)
                CodeViewVC.theStatements.append(self.theStatement!)
            }
            else if(self.nextScreen == "Change Remember")
            {
                var rememberSet = uxRememberSetStatement(name: (self.theStatement as! uxRememberStatement).name)
                rememberSet.value = uxLitExpression(value: litValTF!.text)
                CodeViewVC.theStatements.append(rememberSet)
            }
            else if(self.nextScreen == "Get Right Math Operand")
            {
                self.theMathExpression!.rrand = uxLitExpression(value: litValTF!.text)
            }
            else if(self.nextScreen == "Get Left Math Operand")
            {
                self.theMathExpression!.lrand = uxLitExpression(value: litValTF!.text)
            }
            self.navigationController?.popToRootViewControllerAnimated(true)
        }
        else if(self.theStatement! is uxPrintStatement)
        {
            if(self.nextScreen == "NONE")
            {
                (self.theStatement as! uxPrintStatement).value = uxLitExpression(value: litValTF!.text)
                CodeViewVC.theStatements.append(self.theStatement!)
            }
           self.navigationController?.popToRootViewControllerAnimated(true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        litValTF.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
