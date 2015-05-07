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
    var theOldExpression : uxExpression?
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var currValueLabel: UILabel!
    
    @IBOutlet weak var selectValueButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(CodrCore.statements.last is uxRememberStatement)
        {
            (CodrCore.statements.last as! uxRememberStatement).name = self.nameTF.text
        }
        CodrCore.statements.last?.value = CodrCore.popExpression()
        CodrCore.addStatementToProgram(CodrCore.popStatement())
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func variableNameIsChanging(sender: UITextField)
    {
        (CodrCore.statements.last as! uxRememberStatement).name = sender.text
        
        if(count(sender.text) == 0)
        {
            selectValueButton.enabled = false
            saveButton.enabled = false
        }
        else
        {
            selectValueButton.enabled = true
            if(self.currValueLabel.text != "NEW")
            {
                saveButton.enabled = true
            }
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
        if(self.currValueLabel.text != "NEW")
        {
            saveButton.enabled = true
            self.theOldExpression = nil
        }
        else if(self.theOldExpression != nil)
        {
            CodrCore.pushExpression(self.theOldExpression!)
            self.currValueLabel.text = self.theOldExpression?.displayValue()
            self.theOldExpression = nil
            saveButton.enabled = true
        }
    }
    
    @IBAction func selectValueButtonPressed(sender: AnyObject)
    {
        if(self.currValueLabel.text != "NEW")
        {
            self.theOldExpression = CodrCore.popExpression()
            self.currValueLabel.text = "NEW"
        }
        
        var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        self.navigationController?.pushViewController(getExpressionTVC, animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.nameTF.becomeFirstResponder()
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
