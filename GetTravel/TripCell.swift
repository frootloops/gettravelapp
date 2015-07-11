//
//  TripCell.swift
//  GetTravel
//
//  Created by Arsen Gasparyan on 15/06/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var leftOffset: NSLayoutConstraint!
    @IBOutlet weak var trailingSpace: NSLayoutConstraint!
    @IBOutlet weak var menuButton: UIButton!
    let format = NSDateFormatter()
    weak var tableView: UITableView!
    var touchCenter : CGPoint?

    
    var trip: Trip! {
        didSet {
            cover.image = trip.city.cover
            city.text = trip.city.name
            
            date.text = "..."
            if let tripStart = trip.begin {
                format.dateFormat = "MMMM yyyy"
                date.text = format.stringFromDate(tripStart)
            }
        }
    }
    
    @IBAction func showMenu(sender: UIButton) {
        if (leftOffset.constant == 0) {
            leftOffset.constant = -80
            trailingSpace.constant = 80
            menuButton.setImage(UIImage(named: "options-white"), forState: .Normal)
        } else {
            leftOffset.constant = 0
            trailingSpace.constant = 0
            menuButton.setImage(UIImage(named: "options-edged-white"), forState: .Normal)
        }
        
        UIView.animateWithDuration(0.3) { self.superview!.layoutIfNeeded() }
    }
    
    @IBAction func deleteTrip(sender: UIButton) {
        let indexPath = tableView.indexPathForCell(self)!
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        
        tableView.beginUpdates()
        app.trips.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
        tableView.endUpdates()
        
        JLToast.makeText("Путешествие удалено").show()
    }

    // MARK: - Touch events
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("Began")
        
        if let touch = touches.first as? UITouch {
            touchCenter = touch.locationInView(tableView)
            if (!cover.pointInside(touch.locationInView(cover), withEvent: event)) { return }
            
            if (leftOffset.constant != 0) {
                leftOffset.constant = 0
                trailingSpace.constant = 0
                UIView.animateWithDuration(0.3) { self.superview!.layoutIfNeeded() }
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        tableView.scrollEnabled = false
        
        if let touch = touches.first as? UITouch {
            if (!cover.pointInside(touch.locationInView(cover), withEvent: event)) { return }
            
            let newLocation = touch.locationInView(tableView)
            let prevLocation = touch.previousLocationInView(tableView)
            let newOffset = touchCenter!.x - newLocation.x
            
            if (newOffset > 0) {
                leftOffset.constant = -newOffset
                trailingSpace.constant = newOffset
                superview!.updateConstraints()
            }
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        println("End")
        if let touch = touches.first as? UITouch {
            if (cover.pointInside(touch.locationInView(cover), withEvent: event)) {
                touchIsEnded()
            }
        }
    }
    
    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        println("Cancelled")
        if let touch = touches.first as? UITouch {
            if (cover.pointInside(touch.locationInView(cover), withEvent: event)) {
                touchIsEnded()
            }
        }

    }
    
    private func touchIsEnded() {
        tableView.scrollEnabled = true
        if (leftOffset.constant <= -80) {
            leftOffset.constant = -80
            trailingSpace.constant = 80
        } else {
            leftOffset.constant = 0
            trailingSpace.constant = 0
        }
        
        touchCenter = nil
        UIView.animateWithDuration(0.3) { self.superview!.layoutIfNeeded() }
    }
    
}
