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
    @IBOutlet weak var litValTF: UITextField!
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        (CodrCore.expressions.last as! uxLitExpression).value = litValTF.text
    
        //What kind of statement are we creating a literal for?
        if(CodrCore.statements.last is uxRememberStatement)
        {
            if(CodrCore.theLastVCs.last is RememberStatementVC)
            {
                var rsvc = CodrCore.theLastVCs.last as! RememberStatementVC
                rsvc.currValueLabel.text = self.litValTF.text
                self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
            }
            else if(CodrCore.theLastVCs.last is MathExpVC)
            {
                var mevc = CodrCore.theLastVCs.last as! MathExpVC
                mevc.setExpressionLabel()
                self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
            }
        }
        else if(CodrCore.statements.last is uxPrintStatement)
        {
            (CodrCore.expressions.last as! uxLitExpression).value = self.litValTF.text
            (CodrCore.statements.last as! uxPrintStatement).value = CodrCore.popExpression()
            CodrCore.addStatementToProgram(CodrCore.popStatement())
            self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
        }
    }
    
    override func viewDidLoad()
    {
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
