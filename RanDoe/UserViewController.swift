//
//  ViewController.swift
//  RanDoe
//
//  Created by Jeff Tabios on 21/05/2017.
//  Copyright © 2017 TestOrg. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserViewController: UIViewController {
    
    var user = [String:AnyObject]() //Array

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //Display User
        
        //Get fullname and email
        let firstName=user["name"]!["first"] as? String
        let lastName=user["name"]!["last"] as? String
        let name=firstName! + " " + lastName!
        //let email=user["email"] as? String
        
        fullName.text = name.capitalizedString
        gender.text = user["gender"] as? String
        phone.text = user["phone"] as? String
        email.text = user["email"] as? String
        
        //Photo URL
        let photo=user["picture"]!["large"] as? String
        
        //userImage.image =
        if let url = NSURL(string: photo!) {
            if let data = NSData(contentsOfURL: url) {
                userImage.image = UIImage(data: data)
            }
        }


        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

