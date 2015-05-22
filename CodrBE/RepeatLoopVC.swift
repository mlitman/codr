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
    @IBOutlet weak var iterationsDisplayLabel: UILabel!
    
    @IBAction func setIterationsButtonPressed(sender: UIButton)
    {
        CodrCore.pushLastVC(self)
        var getExpTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
        self.navigationController?.pushViewController(getExpTVC, animated: true)

    }
    
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
        if(self.bodyDisplayLabel.text != "NEW" && self.iterationsDisplayLabel.text != "NEW")
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
