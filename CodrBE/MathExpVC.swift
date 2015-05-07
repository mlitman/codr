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
        if(self.leftOperandValueLabel != "NEW" &&
        self.rightOperandValueLabel != "NEW")
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
    }
    
    @IBAction func setRightOpButtonPressed(sender: AnyObject)
    {
        self.lastClickedButton = rightButton
        var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        self.navigationController?.pushViewController(getExpressionTVC, animated: true)
    }
    
    @IBAction func setLeftOpButtonPressed(sender: AnyObject)
    {
        self.lastClickedButton = leftButton
        var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        self.navigationController?.pushViewController(getExpressionTVC, animated: true)
    }

    @IBAction func opSegmentChanged(sender: UISegmentedControl)
    {
        (CodrCore.expressions.last as! uxMathExpression).op = CodrCore.theMathOps[sender.selectedSegmentIndex]
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
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
