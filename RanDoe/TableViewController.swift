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
import AlamofireImage

class userTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userThumb: UIImageView!
}

class userTableViewController: UITableViewController {

    @IBOutlet var tblJSON: UITableView!
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    var cachedImages = [String: UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Get People list
        Alamofire.request(.GET,"https://randomuser.me/api/?results=25&nat=gb").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                
                print(responseData.result.value!)
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                if let resData = swiftyJsonVar["results"].arrayObject {
                    
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                if self.arrRes.count > 0 {
                    
                    self.tblJSON.reloadData()
                }
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
        // #warning Incomplete implementation, return the number of sections
        
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return arrRes.count
    }

    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("usersCell")!
        var dict = arrRes[indexPath.row]
        
        //Concat name
        let firstName=dict["name"]!["first"] as? String
        let lastName=dict["name"]!["last"] as? String
        let name=firstName! + " " + lastName!
        let email=dict["email"] as? String

        //Photo URL
        let photo=dict["picture"]!["thumbnail"] as? String
        
        //Set cell contents
        cell.textLabel?.text = name.capitalizedString
        cell.detailTextLabel?.text = email
        
        
        //Set User Thumb
        //cell.imageView?.af_setImageWithURL(imageUrl)
        
      //  dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            if let url = NSURL(string: photo!) {
                if let data = NSData(contentsOfURL: url) {
                    cell.imageView?.image = UIImage(data: data)
                }
            }
            
        
        
      //  })
        
        
        
        return cell
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
