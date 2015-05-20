//
//  RepeatLoopVC.swift
//  CodrBE
//
//  Created by Michael Litman on 5/15/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class RepeatLoopVC: UIViewController
{

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bodyDisplayLabel: UILabel!
    @IBOutlet weak var numberOfLoopsTF: UITextField!
    @IBAction func setBodyButtonPressed(sender: UIButton)
    {
        if(self.bodyDisplayLabel.text != "NEW")
        {
            CodrCore.popStatement()
            self.bodyDisplayLabel.text = "NEW"
        }
        
        CodrCore.pushLastVC(self)
        
        var getStatementTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetStatementTVC") as! GetStatementTVC
        self.navigationController?.pushViewController(getStatementTVC, animated: true)

    }
    
    @IBAction func numberOfTimesTFChanged(sender: AnyObject)
    {
        (CodrCore.statements.last as! uxRepeatLoopStatement).numberOfTimes = self.numberOfLoopsTF.text.toInt()
        self.setSaveButton()
    }
    
    @IBAction func saveButtonPressed(sender: AnyObject)
    {
        CodrCore.addStatementToProgram(CodrCore.popStatement())
        self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
    }

    func cancelButtonPressed(sender: UIBarButtonItem)
    {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        CodrCore.cancelButtonLogic(self)
        self.navigationController?.popViewControllerAnimated(true)
    }

    func setSaveButton()
    {
        if(self.bodyDisplayLabel.text != "NEW" && count(self.numberOfLoopsTF.text) != 0)
        {
            self.saveButton.enabled = true
        }
        else
        {
            self.saveButton.enabled = false
        }
    }
    
    override func viewWillAppear(animated: Bool)
    {
       self.setSaveButton()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.numberOfLoopsTF.becomeFirstResponder()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonPressed:")
        self.navigationItem.leftBarButtonItem = newBackButton;

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
