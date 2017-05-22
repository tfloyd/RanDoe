//
//  TableViewController.swift
//  RanDoe
//
//  Created by Jeff Tabios on 21/05/2017.
//  Copyright © 2017 TestOrg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserTableViewController: UITableViewController {

    @IBOutlet var tblJSON: UITableView!
    var userArray = [[String:AnyObject]]() //Array of dictionary
    var cachedImages = [String: UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Get user listing
        Alamofire.request(.GET,"https://randomuser.me/api/?results=15&nat=gb").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    
                    self.userArray = resData as! [[String:AnyObject]]
                }
                if self.userArray.count > 0 {
                    
                    self.tblJSON.reloadData()
                    
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return userArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("usersCell")!
        var dict = userArray[indexPath.row]
        
        //Get fullname and email
        let firstName=dict["name"]!["first"] as? String
        let lastName=dict["name"]!["last"] as? String
        let name=firstName! + " " + lastName!
        let email=dict["email"] as? String

        //Photo URL
        let photo=dict["picture"]!["thumbnail"] as? String
        
        //Set table cell contents
        cell.textLabel?.text = name.capitalizedString
        cell.detailTextLabel?.text = email
        
        //Set User Thumb
        if let url = NSURL(string: photo!) {
            if let data = NSData(contentsOfURL: url) {
                cell.imageView?.image = UIImage(data: data)
            }
        }
        
        return cell
        
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowUserDetail" {
            
            //print("User")
            let nextScene = segue.destinationViewController as? UserViewController
            
            //Pass the selected user details
            if let indexPath = self.tblJSON.indexPathForSelectedRow{
                let selectedUser = userArray[indexPath.row]
                
                //print(selectedUser)
                
                nextScene!.user = selectedUser

            }
            
        }
    }


}
