//
//  1upToModel.swift
//  1UpTo
//
//  Created by Yi-Jui, Chiu on 26/07/2017.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import Foundation

class calendarModel {

    //get all groups
    static func getAllGroups(completionHandler: @escaping (_ data : Data?, _ response : URLResponse?, _ error : Error?) -> Void) {
        
        // Specify the url that we will be sending the GET Request to
        
        
        let url = URL(string: "http://localhost:8000/groups")
        
        // Create a URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllPeople function itself
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
        
        
    }
    
    //get all users
    static func getAllUsers(completionHandler: @escaping (_ data : Data?, _ response : URLResponse?, _ error : Error?) -> Void) {
        
        // Specify the url that we will be sending the GET Request to
        
        
        let url = URL(string: "http://localhost:8000/users")
        
        // Create a URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllPeople function itself
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
        
        
    }
    
    //add user in db
    static func addUser(username : String, userEmail: String, completionHandler : @escaping  (_ data : Data?, _ response : URLResponse?, _ error : Error?) -> Void) {
        
        if let urlToReq = URL(string: "http://localhost:8000/add_user") {
            
            var request = URLRequest(url : urlToReq)
            
            request.httpMethod = "POST"
            
            let bodyData = "name=\(username)&email=\(userEmail)"
            
            request.httpBody = bodyData.data(using: .utf8)
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request as URLRequest, completionHandler : completionHandler)
            
            task.resume()
        }
    }

}
