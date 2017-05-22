# RanDoe
https://github.com/tfloyd/RanDoe

Sample list-detail app using Swift

Requirements:
Xcode 7+, Cocoapods

To deploy or run:
1. Download zip or clone repo
2. From Terminal, go to the projects root directory and run 'pod install' to setup dependencies
3. Open 'RanDoe.xcworkspace' in Xcode
4. Run in simulator 

Summary:
This sample uses Alamofire to download JSON data from https://randomuser.me/
SwiftyJSON is used to handle the JSON data and place it a dictionary
There are 2 views used namely for users list and for a user's detail
The first view uses a table and shows how to list users with their thumbnail, name and email
The second view is a simple detail view that displays the users large image and more standard details.

That's it.
