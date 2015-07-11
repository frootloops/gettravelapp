//
//  NewTripViewController.swift
//  GetTravel
//
//  Created by Arsen Gasparyan on 15/06/15.
//  Copyright (c) 2015 Arsen Gasparyan. All rights reserved.
//

import UIKit

class NewTripViewController: UIViewController {
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var datePickerBar: UIToolbar!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var pickerButtomConstraint: NSLayoutConstraint!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var startDateLable: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var dateSwitch: UISwitch!
    
    var currentDateLabel = UILabel()
    let dateFormatter = NSDateFormatter()
    var trip: Trip!
    var city: City! {
        didSet {
            trip = Trip(city: city, begin: nil, end: nil)
        }
    }
    var fromDate = NSDate() {
        didSet {
            startDateLable.text = dateFormatter.stringFromDate(fromDate)
        }
    }
    var toDate = NSDate() {
        didSet {
            endDateLabel.text = dateFormatter.stringFromDate(toDate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = city.name
        datePicker.addTarget(self, action: "dateChanged:", forControlEvents: .ValueChanged)
        
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateStyle = .MediumStyle
        
        fromDate = NSDate()
        toDate = NSDate().dateByAddingTimeInterval(60 * 60 * 24 * 7)
    }
    
    func dateChanged(sender: UIDatePicker) {
        currentDateLabel.text = dateFormatter.stringFromDate(sender.date)
    }
    
    @IBAction func toggleDates(sender: UISwitch) {
        hideDatePicker()
        if (sender.on) {
            UIView.animateWithDuration(0.3) {
                self.startDateView.alpha = 1
                self.endDateView.alpha = 1
            }
        } else {
            UIView.animateWithDuration(0.3) {
                self.startDateView.alpha = 0
                self.endDateView.alpha = 0
            }
        }
    }
    
    @IBAction func hideDatePicker(sender: UIBarButtonItem) {
        datePickerView.layoutIfNeeded()
        hideDatePicker()
        println("HIDE")
    }

    @IBAction func changeStartDate(sender: UITapGestureRecognizer) {
        currentDateLabel = startDateLable
        datePicker.date = dateFormatter.dateFromString(startDateLable.text!)!
        datePicker.minimumDate = NSDate()
        
        toggleViewColor(sender.view!)
        
        if (self.pickerButtomConstraint.constant < 0) {
            showDatePicker()
        }
    }
    
    
    @IBAction func changeEndDate(sender: UITapGestureRecognizer) {
        currentDateLabel = endDateLabel
        datePicker.date = dateFormatter.dateFromString(endDateLabel.text!)!
        datePicker.minimumDate = dateFormatter.dateFromString(startDateLable.text!)!
        
        toggleViewColor(sender.view!)
        
        if (self.pickerButtomConstraint.constant < 0) {
            showDatePicker()
        }
    }
    
    @IBAction func createTrip(sender: UIButton) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if (dateSwitch.on) {
            trip.begin = dateFormatter.dateFromString(startDateLable.text!)!
            trip.end = dateFormatter.dateFromString(endDateLabel.text!)!
        }
        
        app.trips.insert(trip, atIndex: 0)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        JLToast.makeText("Путешествие создано").show()
    }
    
    private func showDatePicker() {
        self.datePickerView.layoutIfNeeded()
        self.pickerButtomConstraint.constant = 0
        UIView.animateWithDuration(0.3) { self.view.layoutIfNeeded() }
    }
    
    private func hideDatePicker() {
        if (self.pickerButtomConstraint.constant < 0) { return }
        
        self.pickerButtomConstraint.constant = -206
        UIView.animateWithDuration(0.3) { self.view.layoutIfNeeded() }
    }
    
    private func toggleViewColor(view: UIView) {
        let currentColor = view.backgroundColor
        
        UIView.animateWithDuration(0.15, animations: {
            view.backgroundColor = UIColor(hexString: "B8B8B8")
            }, completion: { (flag) -> Void in
                UIView.animateWithDuration(0.15) { view.backgroundColor = currentColor }
        })
    }

}
