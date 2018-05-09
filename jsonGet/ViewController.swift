//
//  ViewController.swift
//  jsonGet
//
//  Created by rajendra reddy on 3/9/18.
//  Copyright © 2018 rajendra reddy. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    var URLreq :URLRequest?
    var URLSes = URLSession(configuration: URLSessionConfiguration.default)
    var URLData :URLSessionDataTask?
    var activity = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.activityIndicatorViewStyle = .gray
        activity.hidesWhenStopped = true
        activity.center = self.view.center
        self.view.addSubview(activity)
        // Do any additional setup after loading the view, typically from a nib.
        URLreq = URLRequest(url: URL(string:"https://rss.itunes.apple.com/api/v1/in/ios-apps/top-free/all/10/explicit.json")!)
        URLreq?.httpMethod = "GET"
        URLData = URLSes.dataTask(with: URLreq!, completionHandler: { (data, response, error) in
            do{
                
                let json:[String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String : Any]
                let feed1 = json["feed"] as! NSDictionary
                    let appDetails2 = (feed1["title"] as! String);
                print(appDetails2)
                let resultsArray = feed1["results"] as! NSArray
                for i in 0..<resultsArray.count{
                    let appDetails = (resultsArray[i] as! NSDictionary);
                    let name = appDetails.value(forKey: "artistName") as! String
                  print(name)
                }
            }
            catch{
                print("error")
            }
        })
        URLData?.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

