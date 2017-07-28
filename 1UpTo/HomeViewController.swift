//
//  HomeViewController.swift
//  1UpTo
//
//  Created by MJ Norona on 7/24/17.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit
import JTAppleCalendar
import GoogleAPIClientForREST

class HomeViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    let formatter = DateFormatter()
    var current = Date()

    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    //Event handling
    private let service = GTLRCalendarService()
    var userEmail = ""
    
    //color navigation
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.17, green:0.24, blue:0.27, alpha:1.0)
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white
//        ]
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red:0.03, green:0.55, blue:0.55, alpha:1.0)
        self.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for:.selected)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = GIDSignIn.sharedInstance().currentUser
        welcomeLabel.text = "Welcome, \(currentUser?.profile.name! ?? "")"
        
        //event handling
        print(currentUser?.profile.email ?? "")
        userEmail = (currentUser?.profile.email)!
        print("Current useremail", userEmail)
        print(GIDSignIn.sharedInstance().hasAuthInKeychain())
//        print("Setting VC: " , currentUser?.profile.name ?? "")
        service.authorizer = currentUser?.authentication.fetcherAuthorizer()
        
        fetchEvents()
        
        //sets the margins of the calendar cells
        setupCalendarView()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddEditEventSegue" {
            let navigation = segue.destination as! UINavigationController
            let addEditEventTableViewController = navigation.topViewController as! AddEditEventTableViewController
            addEditEventTableViewController.delegate = self
            addEditEventTableViewController.pickedDate = current
            print("going here")
        }
    }
    
    
    
    func setupCalendarView() {
        //setup calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        //setup calendar labels
        calendarView.visibleDates { visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        if validCell.isSelected {
            validCell.dateLabel.textColor = UIColor(red:0.03, green:0.30, blue:0.46, alpha:1.0)
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = UIColor.white
            } else {
                validCell.dateLabel.textColor = UIColor.gray
            }
        }
    }
    
    func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else {return}
        if validCell.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        formatter.dateFormat = "yyyy"
        yearLabel.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        monthLabel.text = formatter.string(from: date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //addEditViewController functions
    func cancelButtonPressed(by controller: AddEditEventTableViewController) {
        print("cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    func addButtonPressed(by controller: AddEditEventTableViewController) {
        dismiss(animated: true, completion: nil)
        let start = controller.startDatePicker.date
        let end = controller.endDatePicker.date
        let summary = controller.titleLabel.text
        
        let currentUser = GIDSignIn.sharedInstance().currentUser
        
        createEvent(userEmail, participantEmail: "", startDate: start, endDate: end, summary: summary!, recurrenceRule: "")
        print(start)
        print(end)
        print(summary!)
    }
    
    
    //ALL EVENT HANDLING
    func fetchEvents() {
        
        let query = GTLRCalendarQuery_EventsList.query(withCalendarId: "primary")
        query.maxResults = 10
        
        //change date
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let date = dateformatter.date(from: "2017-06-01 19:30:50 +0000")
        //        print("DATE: ", date!)
        query.timeMin = GTLRDateTime(date: date! )
        query.singleEvents = true
        query.orderBy = kGTLRCalendarOrderByStartTime
        service.executeQuery(
            query,
            delegate: self,
            didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
    }
    
    // Display the start dates and event summaries in the UITextView
    func displayResultWithTicket(
        ticket: GTLRServiceTicket,
        finishedWithObject response : GTLRCalendar_Events,
        error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func createEvent(_ userEmail: String, participantEmail: String, startDate: Date, endDate: Date, summary: String, recurrenceRule: String) {
        let event = GTLRCalendar_Event()
        
        event.creator?.email = userEmail
        
        event.start = GTLRCalendar_EventDateTime()
        event.start?.dateTime = GTLRDateTime(date: startDate)
        event.start?.timeZone = TimeZone.autoupdatingCurrent.identifier
        event.end = GTLRCalendar_EventDateTime()
        event.end?.dateTime = GTLRDateTime(date: endDate)
        event.end?.timeZone = TimeZone.autoupdatingCurrent.identifier
        event.summary = summary
        //        event.recurrence = [recurrenceRule]
        
//        let attendee1 = GTLRCalendar_EventAttendee()
//        //        //        let attendee2 = GTLRCalendar_EventAttendee()
//        attendee1.email = participantEmail
//        //        //        attendee2.email = participantEmail
//        //        //        event.attendees = [attendee1, attendee2]
//        event.attendees = [attendee1]
        
        //        let query = GTLQueryCalendar.queryForEventsInsert(withObject: event, calendarId: "primary")
        let query = GTLRCalendarQuery_EventsInsert.query(withObject: event, calendarId: "primary")
        
        service.executeQuery(
            query,
            delegate: self,
            didFinish: #selector(displayResultSingle(ticket:finishedWithObject:error:)))
        
    }
    
    func displayResultSingle(
        ticket: GTLRServiceTicket,
        finishedWithObject event : GTLRCalendar_Event,
        error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        var eventString = ""
        
        let start  = event.start!.dateTime ?? event.start!.date!
        let startString = DateFormatter.localizedString(
            from: start.date,
            dateStyle: .short,
            timeStyle: .short
        )
        
        let end = event.end!.dateTime ?? event.end!.date!
        let endString = DateFormatter.localizedString(
            from: end.date,
            dateStyle: .short,
            timeStyle: .short
        )
        
        print(event)
        print("ID: " + event.identifier!)
        print("Start: " + startString)
        print("End: " + endString)
        if let recurringEventId = event.recurringEventId {
            print("Recurring Event Id: \(recurringEventId)")//use this id to aggregate events from the same recurring event
        }
        
        if let description = event.summary {
            print("Description: \(description)")
        }
        
        if let location = event.location {
            print("Location: \(location)")
        }
        print("\n")
        eventString += "\(startString) - \(event.summary!)\n"
        
    }

}

extension HomeViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2017 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    
}

extension HomeViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)

        print("DIDSELECT: ", date)
        self.current = date

        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
}

extension HomeViewController {
    
}


