//
//  CitiesTableViewController.swift
//  GetTravel
//
//  Created by Arsen Gasparyan on 15/06/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    let cities = [
        City(name: "London", country: "United Kingdom", cover: UIImage(named: "London")!),
        City(name: "Paris", country: "France", cover: UIImage(named: "Paris")!),
        City(name: "Berlin", country: "German", cover: UIImage(named: "Berlin")!),
        City(name: "New York", country: "US", cover: UIImage(named: "NewYork")!),
        
        City(name: "London", country: "United Kingdom", cover: UIImage(named: "London")!),
        City(name: "Paris", country: "France", cover: UIImage(named: "Paris")!),
        City(name: "Berlin", country: "German", cover: UIImage(named: "Berlin")!),
        City(name: "New York", country: "US", cover: UIImage(named: "NewYork")!),
        
        City(name: "London", country: "United Kingdom", cover: UIImage(named: "London")!),
        City(name: "Paris", country: "France", cover: UIImage(named: "Paris")!),
        City(name: "Berlin", country: "German", cover: UIImage(named: "Berlin")!),
        City(name: "New York", country: "US", cover: UIImage(named: "NewYork")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 88
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    @IBAction func dismiss(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as! CityCell
        cell.city = cities[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        return 0
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let path = self.tableView.indexPathForSelectedRow()!
        if let controller = segue.destinationViewController as? NewTripViewController {
            controller.city = cities[path.row]
        }
    }

}
