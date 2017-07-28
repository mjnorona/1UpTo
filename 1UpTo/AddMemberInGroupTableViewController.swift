//
//  AddMemberInGroupTableViewController.swift
//  1UpTo
//
//  Created by Aaron Chiu on 27/07/2017.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit

class AddMemberInGroupTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    var members = [NSDictionary]()
    var filterMembers = [NSDictionary]()
    
    var groupMemberList = [NSDictionary]()
    
     var searchController = UISearchController(searchResultsController: nil)
    
    func filterContentForSearchText(searchText : String, scope: String = "All") {
        filterMembers = members.filter{
            member in
            return ((member["email"] as? String)!.lowercased().contains(searchText.lowercased()))
        }
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set delegate
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar

        fetchAllUsers()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return filterMembers.count
        }
        
        return members.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addMemberCell", for: indexPath)

        let user : NSDictionary
        
        if searchController.isActive && searchController.searchBar.text != "" {
            user = filterMembers[indexPath.row]
        }else{
            user = members[indexPath.row]
            
        }
        
        cell.textLabel?.text = user["name"] as? String
        cell.detailTextLabel?.text = user["email"] as? String

        return cell
    }
    
    //select user and save into db
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
//         
        
        if cell.accessoryType == .none {
            cell.accessoryType = .checkmark
            groupMemberList.append(members[indexPath.row])
            
        }else{
            cell.accessoryType = .none
            
            
            if groupMemberList.contains(members[indexPath.row]) {
                if let itemToRemoveIdx = groupMemberList.index(of: members[indexPath.row]) {
                    groupMemberList.remove(at: itemToRemoveIdx)
                }
            }
            
        }
    }
    
    
    
    
    
    
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // code here
        print(searchController.searchBar.text!)
        filterContentForSearchText(searchText: searchController.searchBar.text!)
        
    }
    
    //call db api to fetch all users
    func fetchAllUsers() {
    
        calendarModel.getAllUsers(completionHandler: {
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
    
    func saveUserIntoGroup() {
        
    }
    
    
    
    

    

}
