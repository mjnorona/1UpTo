//
//  1upToModel.swift
//  1UpTo
//
//  Created by Yi-Jui, Chiu on 26/07/2017.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import Foundation

class calendarModel {

    static func getAllGroups(completionHandler: @escaping (_ data : Data?, _ response : URLResponse?, _ error : Error?) -> Void) {
        
        // Specify the url that we will be sending the GET Request to
        
        
        let url = URL(string: "http://localhost:8000/")
        
        // Create a URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler that we are passing into the getAllPeople function itself
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // Actually "execute" the task. This is the line that actually makes the request that we set up above
        task.resume()
        
        
    }

}
