//
//  MainVC.swift
//  CodrBE
//
//  Created by Michael Litman on 4/18/15.
//  Copyright (c) 2015 awesomefat. All rights reserved.
//

import UIKit

class MainVC: UIViewController
{
    @IBOutlet weak var consoleTV: UITextView!
    var theJSON : String?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let cJSON = CodrJSON(theJSONstring: theJSON!, theTextView: self.consoleTV)
        cJSON.display()
        println(self.theJSON!)
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
