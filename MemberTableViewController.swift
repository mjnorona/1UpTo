//
//  MemberTableViewController.swift
//  1UpTo
//
//  Created by Yi-Jui, Chiu on 26/07/2017.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit

class MemberTableViewController: UITableViewController {
    
    var members = [String]()
    
    var tempMembers : [String]?

    override func viewDidLoad() {
        super.viewDidLoad()
        members = tempMembers!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = members[indexPath.row]
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


}
