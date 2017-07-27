//
//  SettingsViewController.swift
//  1UpTo
//
//  Created by Yi-Jui, Chiu on 26/07/2017.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit
import GoogleAPIClientForREST

class SettingsViewController: UIViewController,GIDSignInUIDelegate {
    
    private let service = GTLRCalendarService()
    
    var userEmail = ""

    @IBOutlet weak var output: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        
        let currentUser = GIDSignIn.sharedInstance().currentUser
        print(currentUser?.profile.email ?? "")
        userEmail = (currentUser?.profile.email)!
        print(GIDSignIn.sharedInstance().hasAuthInKeychain())
        print("Setting VC: " , currentUser?.profile.name ?? "")
        service.authorizer = currentUser?.authentication.fetcherAuthorizer()
        
        fetchEvents()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        fetchEvents()
    }
    
    
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
        
        var outputText = ""
        if let events = response.items, !events.isEmpty {
            for event in events {
                print("EVENT ID", event.identifier ?? "")
                let start = event.start!.dateTime ?? event.start!.date!
                let startString = DateFormatter.localizedString(
                    from: start.date,
                    dateStyle: .short,
                    timeStyle: .short)
                outputText += "\(startString) - \(event.summary!)\n"
            }
        } else {
            outputText = "No upcoming events found."
        }
        output.text = outputText
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
    
    @IBAction func createBtnPressed(_ sender: UIButton) {
        createEvent(userEmail, participantEmail: "erickjin.lui@gmail.com", startDate: Date(), endDate: Date(timeInterval: 60*60*3, since: Date()), summary: "CREATE EVENT TEST attendee", recurrenceRule: "")
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
        
        let attendee1 = GTLRCalendar_EventAttendee()
//        //        let attendee2 = GTLRCalendar_EventAttendee()
        attendee1.email = participantEmail
//        //        attendee2.email = participantEmail
//        //        event.attendees = [attendee1, attendee2]
        event.attendees = [attendee1]
        
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
        output.text = eventString
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
