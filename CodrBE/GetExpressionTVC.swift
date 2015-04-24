//
//  GetExpressionTVC.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class GetExpressionTVC: UITableViewController
{
    var nextScreen = "NONE"
    var theExpressions : [String] = ["Literal","Remember","Math","Boolean"]
    var theStatement : uxStatement?
    var theMathExpression: uxMathExpression?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(self.theExpressions[indexPath.row] == "Literal")
        {
            var litExpVC = self.storyboard?.instantiateViewControllerWithIdentifier("LitExpressionVC") as! LitExpressionVC
            litExpVC.theStatement = self.theStatement!
            if(self.nextScreen != "NONE")
            {
                litExpVC.nextScreen = self.nextScreen
            }
            self.navigationController?.pushViewController(litExpVC, animated: true)
        }
        else if(self.theExpressions[indexPath.row] == "Remember")
        {
            var remExpVC = self.storyboard?.instantiateViewControllerWithIdentifier("RememberListTVC") as! RememberListTVC
            remExpVC.theStatement = self.theStatement!
            if(self.nextScreen != "NONE")
            {
                remExpVC.nextScreen = self.nextScreen
            }
            self.navigationController?.pushViewController(remExpVC, animated: true)
        }
        else if(self.theExpressions[indexPath.row] == "Math")
        {
            var mathExpVC = self.storyboard?.instantiateViewControllerWithIdentifier("MathExpVC") as! MathExpVC
            self.navigationController?.pushViewController(mathExpVC, animated: true)

        }
        
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
        return self.theExpressions.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel!.text = self.theExpressions[indexPath.row]
        return cell
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
