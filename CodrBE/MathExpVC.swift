//
//  MathExpVC.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class MathExpVC: UIViewController
{
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var leftButton : UIButton!
    @IBOutlet weak var rightButton : UIButton!
    @IBOutlet weak var rightOperandValueLabel: UILabel!
    @IBOutlet weak var leftOperandValueLabel: UILabel!
    @IBOutlet weak var opSegments: UISegmentedControl!
    var lastClickedButton : UIButton?
    
    func setExpressionLabel()
    {
        if(self.lastClickedButton == self.leftButton)
        {
            self.leftOperandValueLabel.text = CodrCore.expressions.last!.displayValue()
            var tempExp = CodrCore.popExpression()
            (CodrCore.expressions.last as! uxMathExpression).lrand = tempExp
        }
        else if(self.lastClickedButton == self.rightButton)
        {
            self.rightOperandValueLabel.text = CodrCore.expressions.last!.displayValue()
            var tempExp = CodrCore.popExpression()
            (CodrCore.expressions.last as! uxMathExpression).rrand = tempExp
        }
        
        //should we enable the save button?
        if(self.leftOperandValueLabel.text != "NEW" &&
        self.rightOperandValueLabel.text != "NEW")
        {
            self.saveButton!.enabled = true
        }
        else
        {
            self.saveButton!.enabled = false
        }
        
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(CodrCore.statements.last is uxRememberStatement ||
            CodrCore.statements.last is uxRememberSetStatement)
        {
            if(CodrCore.theLastVCs.last is RememberStatementVC)
            {
                var rsvc = CodrCore.theLastVCs.last as! RememberStatementVC
                rsvc.currValueLabel.text = CodrCore.expressions.last?.displayValue()
            }
            else if(CodrCore.theLastVCs.last is MathExpVC)
            {
                var mevc = CodrCore.theLastVCs.last as! MathExpVC
                mevc.setExpressionLabel()
            }
            else if(CodrCore.theLastVCs.last is BooleanExpVC)
            {
                var bevc = CodrCore.theLastVCs.last as! BooleanExpVC
                bevc.setExpressionLabel()
            }
        }
        else if(CodrCore.statements.last is uxPrintStatement)
        {
            if(CodrCore.theLastVCs.last is CodeViewVC)
            {
                (CodrCore.statements.last as! uxPrintStatement).value = CodrCore.popExpression()
                CodrCore.addStatementToProgram(CodrCore.popStatement())
            }
            else if(CodrCore.theLastVCs.last is MathExpVC)
            {
                var mevc = CodrCore.theLastVCs.last as! MathExpVC
                mevc.setExpressionLabel()
            }
            else if(CodrCore.theLastVCs.last is BooleanExpVC)
            {
                var bevc = CodrCore.theLastVCs.last as! BooleanExpVC
                bevc.setExpressionLabel()
            }
            else if(CodrCore.theLastVCs.last is RepeatLoopVC)
            {
                var rlvc = CodrCore.theLastVCs.last as! RepeatLoopVC
                rlvc.bodyDisplayLabel.text = (CodrCore.statements.last as! uxRepeatLoopStatement).body.displayValue()
            }
            else if(CodrCore.theLastVCs.last is GetStatementTVC)
            {
                CodrCore.popLastVC()
                var rlvc = CodrCore.theLastVCs.last as! RepeatLoopVC
                var thePrintStmt = CodrCore.popStatement() as! uxPrintStatement
                thePrintStmt.value = CodrCore.popExpression()
                (CodrCore.statements.last as! uxRepeatLoopStatement).body = thePrintStmt
                rlvc.bodyDisplayLabel.text = (CodrCore.statements.last as! uxRepeatLoopStatement).body.displayValue()
            }

        }
        else if(CodrCore.statements.last is uxRepeatLoopStatement)
        {
            if(CodrCore.theLastVCs.last is MathExpVC)
            {
                var mevc = CodrCore.theLastVCs.last as! MathExpVC
                mevc.setExpressionLabel()
            }
            else
            {
                (CodrCore.statements.last as! uxRepeatLoopStatement).numberOfTimes = CodrCore.popExpression()
                var rlvc = CodrCore.theLastVCs.last as! RepeatLoopVC
                rlvc.iterationsDisplayLabel.text = (CodrCore.statements.last as! uxRepeatLoopStatement).numberOfTimes.displayValue()
            }
        }
        self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
    }
    
    @IBAction func setRightOpButtonPressed(sender: AnyObject)
    {
        CodrCore.pushLastVC(self)
        self.lastClickedButton = rightButton
        var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        self.navigationController?.pushViewController(getExpressionTVC, animated: true)
    }
    
    @IBAction func setLeftOpButtonPressed(sender: AnyObject)
    {
        CodrCore.pushLastVC(self)
        self.lastClickedButton = leftButton
        var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        self.navigationController?.pushViewController(getExpressionTVC, animated: true)
    }

    @IBAction func opSegmentChanged(sender: UISegmentedControl)
    {
        (CodrCore.expressions.last as! uxMathExpression).op = CodrCore.theMathOps[sender.selectedSegmentIndex]
    }

    func cancelButtonPressed(sender: UIBarButtonItem)
    {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        CodrCore.cancelButtonLogic(self)
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonPressed:")
        self.navigationItem.leftBarButtonItem = newBackButton;

        (CodrCore.expressions.last as! uxMathExpression).op = CodrCore.theMathOps[opSegments.selectedSegmentIndex]
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
