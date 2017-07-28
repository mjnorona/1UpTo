//
//  AddEditEventTableViewController.swift
//  1UpTo
//
//  Created by MJ Norona on 7/26/17.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit

class AddEditEventTableViewController: UITableViewController {
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    var pickedDate: Date?
    
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var startCell: UITableViewCell!
    @IBOutlet weak var endCell: UITableViewCell!
    @IBOutlet weak var alertCell: UITableViewCell!
    
    //start event
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    //end event
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    
    
    
    
    weak var delegate: HomeViewController?
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        delegate?.addButtonPressed(by: self)
    }
    
    
    @IBAction func startDatePickerChanged(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "MMM d, YYYY"
        timeFormatter.dateFormat = "h:mm a"
        
        let startDate = dateFormatter.string(from: startDatePicker.date)
        let startTime = timeFormatter.string(from: startDatePicker.date)
        
        startDateLabel.text = startDate
        startTimeLabel.text = startTime
    }
    
    
    
    
    
    
    
    @IBAction func endDatePickerChanged(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "MMM d, YYYY"
        timeFormatter.dateFormat = "h:mm a"
        
        let endDate = dateFormatter.string(from: endDatePicker.date)
        let endTime = timeFormatter.string(from: endDatePicker.date)
        
        endDateLabel.text = endDate
        endTimeLabel.text = endTime
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startCell?.textLabel?.text = "Start"
        endCell?.textLabel?.text = "End"
        alertCell.textLabel?.text = "Alert"
        
        dateFormatter.dateFormat = "MMM d, YYYY"
        timeFormatter.dateFormat = "h:mm a"
        self.hideKeyboardWhenTappedAround()
        
        
        let calendar = Calendar.current
        
        //starting
        let currentDate = dateFormatter.string(from: pickedDate!)
        let currentTime = timeFormatter.string(from: pickedDate!)
        
        startDateLabel.text = currentDate
        startTimeLabel.text = currentTime
        
        startDatePicker.date = pickedDate!
        
        //ending
        let date = calendar.date(byAdding: .minute, value: 30, to: pickedDate!)
        
        let laterDate = dateFormatter.string(from: date!)
        let laterTime = timeFormatter.string(from: date!)
        
        endDateLabel.text = laterDate
        endTimeLabel.text = laterTime
        
        endDatePicker.date = date!
        
        
        
        self.tableView.backgroundColor = UIColor(red:0.00, green:0.28, blue:0.29, alpha:1.0)        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
