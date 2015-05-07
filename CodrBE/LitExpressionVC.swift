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
            var sourceVC = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count-3]
            if(sourceVC is RememberStatementVC)
            {
                var rsvc = sourceVC as! RememberStatementVC
                rsvc.currValueLabel.text = self.litValTF.text
                self.navigationController?.popToViewController(rsvc, animated: true)
            }
            else if(sourceVC is MathExpVC)
            {
                var mevc = sourceVC as! MathExpVC
                mevc.setExpressionLabel()
                self.navigationController?.popToViewController(self.navigationController!.viewControllers[self.navigationController!.viewControllers.count-3] as! UIViewController, animated: true)
            }
        }
        else if(CodrCore.statements.last is uxPrintStatement)
        {
            (CodrCore.statements.last as! uxPrintStatement).value = uxLitExpression(value:self.litValTF.text)
            CodrCore.addStatementToProgram(CodrCore.popStatement())
        self.navigationController?.popToViewController(self.navigationController!.viewControllers[self.navigationController!.viewControllers.count-3] as! UIViewController, animated: true)
            
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
