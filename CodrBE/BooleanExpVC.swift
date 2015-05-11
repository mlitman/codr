//
//  BooleanExpVC.swift
//  CodrBE
//
//  Created by Michael Litman on 5/11/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class BooleanExpVC: UIViewController
{
    @IBOutlet weak var saveButton : UIButton!
    @IBOutlet weak var leftButton : UIButton!
    @IBOutlet weak var rightButton : UIButton!
    @IBOutlet weak var rightOperandValueLabel: UILabel!
    @IBOutlet weak var leftOperandValueLabel: UILabel!
    @IBOutlet weak var opTypeLabel: UILabel!
    @IBOutlet weak var arithmeticSegments: UISegmentedControl!
    @IBOutlet weak var logicalSegments: UISegmentedControl!
    var lastClickedButton : UIButton?
    var boolExp : uxBooleanExpression!
    
    @IBAction func toggleSegments(sender: UISwitch)
    {
        if(sender.on)
        {
            self.arithmeticSegments.hidden = false
            self.logicalSegments.hidden = true
            self.boolExp.type = "arithmetic"
            self.boolExp.op = CodrCore.theArithmeticBooleanOps[self.arithmeticSegments.selectedSegmentIndex]
            self.leftButton.enabled = true
            self.leftOperandValueLabel.enabled = true
            
        }
        else
        {
            self.arithmeticSegments.hidden = true
            self.logicalSegments.hidden = false
            self.boolExp.type = "logical"
            self.boolExp.op = CodrCore.theLogicalBooleanOps[self.logicalSegments.selectedSegmentIndex]
            if(self.boolExp.op == "not")
            {
                self.leftButton.enabled = false
                self.leftOperandValueLabel.enabled = false
            }
        }
        self.opTypeLabel.text = self.boolExp.type
    }
    
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
            self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
        }
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
        if(self.boolExp.type == "arithmetic")
        {
            self.boolExp.op = CodrCore.theArithmeticBooleanOps[self.arithmeticSegments.selectedSegmentIndex]
        }
        else
        {
            self.boolExp.op = CodrCore.theLogicalBooleanOps[self.logicalSegments.selectedSegmentIndex]
        }
        if(self.boolExp.type == "logical" && self.boolExp.op == "not")
        {
            self.leftButton.enabled = false
            self.leftOperandValueLabel.enabled = false
        }
        else
        {
            self.leftButton.enabled = true
            self.leftOperandValueLabel.enabled = true
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.arithmeticSegments.hidden = false
        self.logicalSegments.hidden = true
        self.boolExp = CodrCore.expressions.last as! uxBooleanExpression
        self.boolExp.type = "arithmetic"
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
