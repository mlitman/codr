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
    var nameStartingText = "NEW"
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var currValueLabel: UILabel!
    
    @IBOutlet weak var selectValueButton: UIButton!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        if(CodrCore.statements.last is uxRememberStatement)
        {
            if(CodrCore.hasRemember(self.nameTF.text))
            {
                var av = UIAlertView(title: "Error", message: "Variable Already Exists!", delegate: nil, cancelButtonTitle: "OK")
                av.show()
                return
            }
            (CodrCore.statements.last as! uxRememberStatement).name = self.nameTF.text
            CodrCore.statements.last?.value = CodrCore.popExpression()
            CodrCore.addStatementToProgram(CodrCore.popStatement())
        }
        else if(CodrCore.statements.last is uxRememberSetStatement)
        {
            (CodrCore.statements.last as! uxRememberSetStatement).name = self.nameTF.text
            CodrCore.statements.last?.value = CodrCore.popExpression()
            
            if(CodrCore.theLastVCs.last is GetStatementTVC)
            {
                //we were called from the Repeat Loop
                CodrCore.popLastVC()
                if(CodrCore.theLastVCs.last is RepeatLoopVC)
                {
                    var theRememberSetStmt = CodrCore.popStatement() as! uxRememberSetStatement
                    (CodrCore.statements.last as! uxRepeatLoopStatement).body = theRememberSetStmt
                    var rlvc = CodrCore.theLastVCs.last as! RepeatLoopVC
                    rlvc.bodyDisplayLabel.text = theRememberSetStmt.displayValue()
                }
            }
            else if(CodrCore.theLastVCs.last is CodeViewVC)
            {
                CodrCore.addStatementToProgram(CodrCore.popStatement())
            }
        }
        self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
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
        
        //Let CodrCore know that we were the dude that called getExpression
        CodrCore.pushLastVC(self)
        
        var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        self.navigationController?.pushViewController(getExpressionTVC, animated: true)
    }
    
    func cancelButtonPressed(sender: UIBarButtonItem)
    {
        CodrCore.cancelButtonLogic(self)
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonPressed:")
        self.navigationItem.leftBarButtonItem = newBackButton;

        if(self.nameStartingText != "NEW")
        {
            self.nameTF.text = self.nameStartingText
            self.nameTF.enabled = false
            self.selectValueButton.enabled = true
        }
        else
        {
            self.nameTF.becomeFirstResponder()
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
