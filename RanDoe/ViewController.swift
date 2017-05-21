//
//  ViewController.swift
//  RanDoe
//
//  Created by Jeff Tabios on 21/05/2017.
//  Copyright © 2017 TestOrg. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Pop Alert for Internet Warning
        let alertController = UIAlertController(title: "Internet is gone", message: "Please check your internet", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        
        //Internet Watch
        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock { (status: AFNetworkReachabilityStatus) -> Void in
            switch status {
            case .NotReachable:
                self.presentViewController(alertController, animated: true, completion: nil)
                print("Not reachable")
            case .ReachableViaWiFi, .ReachableViaWWAN:
                print("Reachable")
            case .Unknown:
                print("Unknown")
            }
            
        }
        AFNetworkReachabilityManager.sharedManager().startMonitoring()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

