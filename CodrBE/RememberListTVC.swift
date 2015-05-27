//
//  RememberListTVC.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class RememberListTVC: UITableViewController
{
    var theRemembers : [uxRememberStatement]!
    var theStatement : uxStatement?
    
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

        self.theRemembers = CodrCore.getRememberStatements()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.theRemembers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel!.text = self.theRemembers[indexPath.row].listDisplayValue()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //what kind of statement is expecting my value?
        if(CodrCore.statements.last is uxPrintStatement)
        {
            (CodrCore.expressions.last as! uxVarExpression).name = self.theRemembers[indexPath.row].name
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
            else if(CodrCore.theLastVCs.last is GetStatementTVC)
            {
                CodrCore.popLastVC()
                if(CodrCore.theLastVCs.last is RepeatLoopVC)
                {
                    CodrCore.statements.last!.value = CodrCore.popExpression()
                    if(CodrCore.statements.last is uxPrintStatement)
                    {
                        var thePrintStmt = CodrCore.popStatement() as! uxPrintStatement
                        (CodrCore.statements.last as! uxRepeatLoopStatement).body = thePrintStmt
                    
                        var rlvc = CodrCore.theLastVCs.last as! RepeatLoopVC
                        rlvc.bodyDisplayLabel.text = thePrintStmt.displayValue()
                    }
                    else if(CodrCore.statements.last is uxRememberSetStatement)
                    {
                        var theRememberSetStmt = CodrCore.popStatement() as! uxRememberSetStatement
                        (CodrCore.statements.last as! uxRepeatLoopStatement).body = theRememberSetStmt
                        
                        var rlvc = CodrCore.theLastVCs.last as! RepeatLoopVC
                        rlvc.bodyDisplayLabel.text = theRememberSetStmt.displayValue()
                    }
                }

            }
            self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
        }
        else if(CodrCore.statements.last is uxRememberStatement)
        {
            (CodrCore.expressions.last as! uxVarExpression).name = self.theRemembers[indexPath.row].name
            if(CodrCore.theLastVCs.last is RememberStatementVC)
            {
                var rsvc = CodrCore.theLastVCs.last as! RememberStatementVC
                rsvc.currValueLabel.text = self.theRemembers[indexPath.row].name
            
                self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
            }
            else if(CodrCore.theLastVCs.last is MathExpVC)
            {
                var mevc = CodrCore.theLastVCs.last as! MathExpVC
                mevc.setExpressionLabel()
                self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
            }
            else if(CodrCore.theLastVCs.last is BooleanExpVC)
            {
                var bevc = CodrCore.theLastVCs.last as! BooleanExpVC
                bevc.setExpressionLabel()
                self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
            }
        }
        else if(CodrCore.statements.last is uxRememberSetStatement)
        {
            if(CodrCore.theLastVCs.last is RememberStatementVC)
            {
                var rsvc = CodrCore.theLastVCs.last as! RememberStatementVC
                rsvc.currValueLabel.text = self.theRemembers[indexPath.row].name
                self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
            }
            else if(CodrCore.theLastVCs.last is MathExpVC)
            {
                (CodrCore.expressions.last as! uxVarExpression).name = self.theRemembers[indexPath.row].name
                var mevc = CodrCore.theLastVCs.last as! MathExpVC
                mevc.setExpressionLabel()
                self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
            }
            else if(CodrCore.theLastVCs.last is BooleanExpVC)
            {
                (CodrCore.expressions.last as! uxVarExpression).name = self.theRemembers[indexPath.row].name
                var bevc = CodrCore.theLastVCs.last as! BooleanExpVC
                bevc.setExpressionLabel()
                self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
            }
            else
            {
                var rsvc = self.storyboard?.instantiateViewControllerWithIdentifier("RememberStatementVC") as! RememberStatementVC
                rsvc.nameStartingText = self.theRemembers[indexPath.row].name
                self.navigationController?.pushViewController(rsvc, animated: true)
            }
        }
        else if(CodrCore.statements.last is uxRepeatLoopStatement)
        {
            if(CodrCore.theLastVCs.last is MathExpVC)
            {
                var mevc = CodrCore.theLastVCs.last as! MathExpVC
                mevc.setExpressionLabel()
            }
            else if(CodrCore.theLastVCs.last is BooleanExpVC)
            {
                var bevc = CodrCore.theLastVCs.last as! BooleanExpVC
                bevc.setExpressionLabel()
            }
            else
            {
                (CodrCore.statements.last as! uxRepeatLoopStatement).numberOfTimes = CodrCore.popExpression()
                var rlvc = CodrCore.theLastVCs.last as! RepeatLoopVC
                rlvc.iterationsDisplayLabel.text = (CodrCore.statements.last as! uxRepeatLoopStatement).numberOfTimes.displayValue()
            }
            self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
