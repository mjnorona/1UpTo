//
//  MemberTableViewController.swift
//  1UpTo
//
//  Created by Yi-Jui, Chiu on 26/07/2017.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit
import Alamofire

class MemberTableViewController: UITableViewController {
    
    var members = [NSDictionary]()
    
    var tempGroup : NSDictionary?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = tempGroup?["name"] as? String
        
        getAllMembersFromGroup(groupName: tempGroup?["name"] as! String)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        cell.textLabel?.text = members[indexPath.row]["name"] as? String
        cell.detailTextLabel?.text = members[indexPath.row]["email"] as? String
        return cell
    }
    
    
    @IBAction func addMemberBtnPressed(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "AddMemberSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddMemberSegue" {
            let navController = segue.destination as! UINavigationController
            _ = navController.topViewController as! AddMemberInGroupTableViewController
        
        }
    }
    
    
    

    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)

    }
    
    
    
    
    
    func getAllMembersFromGroup(groupName : String){
        
        calendarModel.getAllMembersinGroup(groupName: groupName, completionHandler: {
            data, response, error in
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] {
//                    print("results:", jsonResult)
                    self.members = jsonResult
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch{
            }
        })
    }
    
    
    
    @IBAction func unWindFromMemberList(segue : UIStoryboardSegue) {
        
        let source = segue.source as! AddMemberInGroupTableViewController
        let membersList = source.groupMemberList
        

        
        let groupName = (tempGroup?["name"] as? String)!
        
        
        let parameters: Parameters = [
            "member": membersList,
        ]
        
        Alamofire.request("http://34.213.11.157/members/\(groupName)", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            
            if let groups = response.result.value as? [NSDictionary] {
                print("group Results: ", groups)
                
                
                self.getAllMembersFromGroup(groupName: self.tempGroup?["name"] as! String)
            
            }
        
        
        })
        
        
        
    
    }
    
    
    
    
    
    

}
