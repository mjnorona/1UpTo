//
//  MenuViewController.swift
//  1UpTo
//
//  Created by Yi-Jui, Chiu on 25/07/2017.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let menuItems = ["Friends", "Posts", "Memories"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCell", for: indexPath) as! MenuTableViewCell
        cell.menuItemLabel.text = menuItems[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController : SWRevealViewController = self.revealViewController()
        let cell : MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        
        if cell.menuItemLabel.text == "Friends" {
            let mainStoryboard : UIStoryboard = UIStoryboard(name : "Main", bundle : nil)
            let destController = mainStoryboard.instantiateViewController(withIdentifier: "FriendsViewController") as! FriendsViewController
            let newFrontViewController = UINavigationController.init(rootViewController: destController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.menuItemLabel.text == "Posts" {
            let mainStoryboard : UIStoryboard = UIStoryboard(name : "Main", bundle : nil)
            let destController = mainStoryboard.instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
            let newFrontViewController = UINavigationController.init(rootViewController: destController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.menuItemLabel.text == "Memories" {
            let mainStoryboard : UIStoryboard = UIStoryboard(name : "Main", bundle : nil)
            let destController = mainStoryboard.instantiateViewController(withIdentifier: "MemoriesViewController") as! MemoriesViewController
            let newFrontViewController = UINavigationController.init(rootViewController: destController)
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
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
