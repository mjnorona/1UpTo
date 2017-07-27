//
//  GroupViewController.swift
//  1UpTo
//
//  Created by Yi-Jui, Chiu on 25/07/2017.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    var groups = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.target = revealViewController()
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        fetchAllgroup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        cell.textLabel?.text = groups[indexPath.row]["name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "memberSegue", sender: groups[indexPath.row]["members"])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "memberSegue" {
            let navController = segue.destination as! UINavigationController
            let controller = navController.topViewController as! MemberTableViewController
            controller.tempMembers = sender as? [String]
        
        }
    }

    
    
    func fetchAllgroup() {
    
        calendarModel.getAllGroups(completionHandler: {
                data, response, error in
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [NSDictionary] {
                print("results:", jsonResult)
                    self.groups = jsonResult
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }catch{
            }
        })
    
    
    }

}
