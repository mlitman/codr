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
    var theRemembers = [uxRememberStatement]()
    var theStatement : uxStatement?
    var nextScreen = "NONE"
    override func viewDidLoad()
    {
        super.viewDidLoad()
        for stmt in CodeViewVC.theStatements
        {
            if(stmt is uxRememberStatement)
            {
                self.theRemembers.append(stmt as! uxRememberStatement)
            }
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
        cell.textLabel!.text = self.theRemembers[indexPath.row].displayValue()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        //is this the end of the line?
        if(self.nextScreen == "NONE")
        {
            if(self.theStatement! is uxRememberStatement)
            {
                (self.theStatement as! uxRememberStatement).value = uxVarExpression(name: self.theRemembers[indexPath.row].name)
                CodeViewVC.theStatements.append(self.theStatement!)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            else if(self.theStatement! is uxPrintStatement)
            {
                (self.theStatement as! uxPrintStatement).value = uxVarExpression(name: self.theRemembers[indexPath.row].name)
                CodeViewVC.theStatements.append(self.theStatement!)
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
        }
        else if(self.nextScreen == "Change Remember")
        {
            var remStmtVC = self.storyboard?.instantiateViewControllerWithIdentifier("RememberStatementVC") as! RememberStatementVC
            remStmtVC.theRememberStatement = self.theRemembers[indexPath.row]
            remStmtVC.nextScreen = "Change Remember"
            self.navigationController?.pushViewController(remStmtVC, animated: true)
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
