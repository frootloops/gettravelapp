//
//  TripsTableViewController.swift
//  GetTravel
//
//  Created by Arsen Gasparyan on 15/06/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit

class TripsTableViewController: UITableViewController {
    
    var trips : [Trip] {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        return app.trips
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    @IBAction func startRefreshing(sender: UIRefreshControl) {
        refreshControl!.endRefreshing()
    }
        
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (trips.count > 0) {
            tableView.separatorStyle = .SingleLine
            return 1
        } else {
            // Display a message when the table is empty
            let messageLabel = UILabel(frame: CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height))
            
            messageLabel.text = "Ничего не найдено :(";
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .Center;
            messageLabel.sizeToFit()
            
            tableView.backgroundView = messageLabel
            tableView.separatorStyle = .None
            
            return 0
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TripCell", forIndexPath: indexPath) as! TripCell
        cell.trip = trips[indexPath.row]
        cell.tableView = tableView

        return cell
    }

}
