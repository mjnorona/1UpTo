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
    }
    
    
    @IBAction func startDatePickerChanged(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "MMM dd, YYYY"
        timeFormatter.dateFormat = "h:mm a"
        
        let strDate = dateFormatter.string(from: startDatePicker.date)
        let strTime = timeFormatter.string(from: startDatePicker.date)
        startDateLabel.text = strDate
        startTimeLabel.text = strTime
    }
    
    
    @IBAction func endDatePickerChanged(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "MMM dd, YYYY"
        timeFormatter.dateFormat = "h:mm a"
        
        let strDate = dateFormatter.string(from: endDatePicker.date)
        let strTime = timeFormatter.string(from: endDatePicker.date)
        endDateLabel.text = strDate
        endTimeLabel.text = strTime
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startCell?.textLabel?.text = "Start"
        endCell?.textLabel?.text = "End"
        alertCell.textLabel?.text = "Alert"
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
