//
//  RememberStatementVC.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class RememberStatementVC: UIViewController
{
    var theExpression : uxExpression?
    var theRememberStatement : uxRememberStatement?
    var nextScreen = "NONE"
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var currValueLabel: UILabel!
    
    @IBAction func selectValueButtonPressed(sender: AnyObject)
    {
        var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        if(theRememberStatement == nil)
        {
            theRememberStatement = uxRememberStatement(name: self.nameTF!.text)
        }
        else
        {
            getExpressionTVC.nextScreen = "Change Remember"
        }
       getExpressionTVC.theStatement = theRememberStatement!
        self.navigationController?.pushViewController(getExpressionTVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.nextScreen == "NONE")
        {
            self.nameTF.becomeFirstResponder()
        }
        else
        {
            //populate the form with the current data
            self.nameTF.text = self.theRememberStatement!.name
            self.currValueLabel!.text = self.theRememberStatement!.displayValue()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
