//
//  AppDelegate.swift
//  GetTravel
//
//  Created by Arsen Gasparyan on 15/06/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var trips = [
        Trip(city: City(name: "Berlin", country: "German", cover: UIImage(named: "Berlin")!), begin: NSDate(), end: NSDate()),
        Trip(city: City(name: "Paris", country: "Franch", cover: UIImage(named: "Paris")!), begin: NSDate(), end: NSDate()),
        Trip(city: City(name: "New York", country: "US", cover: UIImage(named: "NewYork")!), begin: NSDate(), end: NSDate()),
        Trip(city: City(name: "London", country: "United Kingdom", cover: UIImage(named: "London")!), begin: NSDate(), end: NSDate()),
        
    ]


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UINavigationBar.appearance().barTintColor = UIColor(hexString: "#22A4DB")
        UINavigationBar.appearance().barStyle = UIBarStyle.Black
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()

        return true
    }

}

