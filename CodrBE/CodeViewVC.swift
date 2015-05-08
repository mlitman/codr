//
//  CodeViewVC.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class CodeViewVC: UITableViewController
{
    @IBOutlet var tv: UITableView!
    @IBAction func runButtonPressed(sender: UIBarButtonItem)
    {
        var mainVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! MainVC
        mainVC.theJSON = self.genJSON()
        self.navigationController?.pushViewController(mainVC, animated: true)

    }
    
    func genJSON() -> String
    {
        var answer = ""
        var header = "{\"statements\":["
        var footer = "]}"
        for stmt in CodrCore.theProgram
        {
            if(count(answer) == 0)
            {
                answer = stmt.toJSON()
            }
            else
            {
                answer = "\(answer),\(stmt.toJSON())"
            }
        }
        return header + answer + footer
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.tv.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tv.editing = false
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
        return 2
    }

     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if(section == 0)
        {
            return CodrCore.theToolBox.count
        }
        else
        {
            return CodrCore.theProgram.count
        }
    }

    override func tableView(tableView: UITableView,
        titleForHeaderInSection section: Int) -> String?
    {
        if(section == 0)
        {
            return "The Toolbox"
        }
        else
        {
            return "Source Code"
        }
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        if(indexPath.section == 0)
        {
            cell.textLabel!.text = CodrCore.theToolBox[indexPath.row]
            cell.editing = false
        }
        else
        {
            cell.textLabel!.text = CodrCore.theProgram[indexPath.row].displayValue()
        }
        return cell
    }

    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if(indexPath.section == 0)
        {
            //Let CodrCore know that we were the dude that called getExpression
            CodrCore.pushLastVC(self)
            
            if(CodrCore.theToolBox[indexPath.row] == "Create Remember")
            {
                CodrCore.pushStatement(uxRememberStatement())
                var remStmtVC = self.storyboard?.instantiateViewControllerWithIdentifier("RememberStatementVC") as! RememberStatementVC
                self.navigationController?.pushViewController(remStmtVC, animated: true)
            }
            else if(CodrCore.theToolBox[indexPath.row] == "Change Remember")
            {
                CodrCore.pushStatement(uxRememberSetStatement())
                var remListTVC = self.storyboard?.instantiateViewControllerWithIdentifier("RememberListTVC") as! RememberListTVC
                self.navigationController?.pushViewController(remListTVC, animated: true)
            }
            else if(CodrCore.theToolBox[indexPath.row] == "Print")
            {
                CodrCore.pushStatement(uxPrintStatement())
                var getExpressionTVC = self.storyboard?.instantiateViewControllerWithIdentifier("GetExpressionTVC") as! GetExpressionTVC
                self.navigationController?.pushViewController(getExpressionTVC, animated: true)
            }
        }
        else
        {
            
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

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath)
    {
        if(fromIndexPath.section == 1)
        {
            var temp = CodrCore.theProgram[fromIndexPath.row]
            CodrCore.theProgram[toIndexPath.row] = CodrCore.theProgram[fromIndexPath.row]
            CodrCore.theProgram[fromIndexPath.row] = temp
        }
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        if(indexPath.section == 1)
        {
            return true
        }
        else
        {
            return false
        }
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
