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
    @IBOutlet weak var opSegments: UISegmentedControl!
    var ops = ["+","-","*","/"]
    var selectedIndex = 0
    var theExpression : uxMathExpression?
    
    @IBAction func setRightOpButtonPressed(sender: AnyObject)
    {
        var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        theExpression!.op!  = self.ops[self.selectedIndex]
        getExpressionTVC.nextScreen = "Get Right Math Operand"
        getExpressionTVC.theMathExpression = theExpression
        self.navigationController?.pushViewController(getExpressionTVC, animated: true)
    }
    @IBAction func setLeftOpButtonPressed(sender: AnyObject)
    {
        var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        self.theExpression!.op!  = self.ops[self.selectedIndex]
        getExpressionTVC.nextScreen = "Get Left Math Operand"
        getExpressionTVC.theMathExpression = theExpression
        self.navigationController?.pushViewController(getExpressionTVC, animated: true)
    }

    @IBAction func opSegmentChanged(sender: UISegmentedControl)
    {
        self.selectedIndex = sender.selectedSegmentIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.opSegments.selectedSegmentIndex = self.selectedIndex
        theExpression = uxMathExpression()
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
