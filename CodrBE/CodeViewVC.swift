//
//  CodeViewVC.swift
//  CodrBE
//
//  Created by Michael Litman on 4/19/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class CodeViewVC: UIViewController
{
    var originalCodeViewVC = true
    @IBOutlet var tv: UITableView!
    
    func cancelButtonPressed(sender: UIBarButtonItem)
    {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
        CodrCore.cancelButtonLogic(self)
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func saveButtonPressed(sender: UIBarButtonItem)
    {
        //Only exists for non-original CodeViewVC
        //for example: setting the body of a loop
        (CodrCore.statements.last as! uxLoopStatement).body = CodrCore.popStatementCollection()
        if(CodrCore.statements.last is uxRepeatLoopStatement)
        {
            //Get rid of the GetStatementVC so I can go back to RepeatLoopVC
            CodrCore.popLastVC()
            (CodrCore.theLastVCs.last as! RepeatLoopVC).bodyDisplayLabel.text = (CodrCore.statements.last as! uxLoopStatement).body.displayValue()
        }
        self.navigationController?.popToViewController(CodrCore.popLastVC(), animated: true)
    }

    @IBAction func editButtonPressed(sender: UIBarButtonItem)
    {
        if(sender.title! == "edit")
        {
            self.tv.editing = true
            sender.title! = "done"
        }
        else
        {
            self.tv.editing = false
            sender.title! = "edit"
        }
        
    }
    @IBAction func runButtonPressed(sender: UIBarButtonItem)
    {
        var mainVC = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! MainVC
        mainVC.theJSON = self.genJSON()
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
    func genJSON() -> String
    {
        //var answer = ""
        return CodrCore.theStatementCollections.last!.toJSON()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.tv.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if I am not the original CodeViewVC, I need to fix menu options
        if(!self.originalCodeViewVC)
        {
            self.navigationItem.hidesBackButton = true
            let newBackButton = UIBarButtonItem(title: "cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelButtonPressed:")
            self.navigationItem.leftBarButtonItem = newBackButton;
            
            let newRightButton = UIBarButtonItem(title: "save", style: UIBarButtonItemStyle.Plain, target: self, action: "saveButtonPressed:")
            self.navigationItem.rightBarButtonItem = newRightButton;
        }
        //set the initial statement collection for the program
        CodrCore.pushStatementCollection(uxStatementCollection())
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

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if(section == 0)
        {
            return CodrCore.theToolBox.count
        }
        else
        {
            return CodrCore.theStatementCollections.last!.theCollection.count
        }
    }

    func tableView(tableView: UITableView,
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        if(indexPath.section == 0)
        {
            cell.textLabel!.text = CodrCore.theToolBox[indexPath.row]
        }
        else
        {
            cell.textLabel!.text = CodrCore.theStatementCollections.last!.theCollection[indexPath.row].displayValue()
        }
        return cell
    }

    func tableView(tableView: UITableView,
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
            else if(CodrCore.theToolBox[indexPath.row] == "Loop")
            {
                var lltvc = self.storyboard?.instantiateViewControllerWithIdentifier("LoopListTVC") as! LoopListTVC
                self.navigationController?.pushViewController(lltvc, animated: true)
            }
            else if(CodrCore.theToolBox[indexPath.row] == "Statement Collection")
            {
                var cvvc = self.storyboard?.instantiateViewControllerWithIdentifier("CodeViewVC") as! CodeViewVC
                cvvc.originalCodeViewVC = false
            self.navigationController?.pushViewController(cvvc, animated: true)
            }
        }
        else
        {
            
        }
    }
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath)
    {
        CodrCore.theStatementCollections.last!.theCollection.removeAtIndex(indexPath.row)
        self.tv.reloadData()
    }
    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        // Return NO if you do not want the specified item to be editable.
        return indexPath.section == 1
    }
    

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
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath)
    {
        if(fromIndexPath.section == 1)
        {
            if(toIndexPath.section != 0)
            {
                var temp = CodrCore.theStatementCollections.last!.theCollection[toIndexPath.row]
                CodrCore.theStatementCollections.last!.theCollection[toIndexPath.row] = CodrCore.theStatementCollections.last!.theCollection[fromIndexPath.row]
                CodrCore.theStatementCollections.last!.theCollection[fromIndexPath.row] = temp
            }
        }
        self.tv.reloadData()
    }
    

    
    // Override to support conditional rearranging of the table view.
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
