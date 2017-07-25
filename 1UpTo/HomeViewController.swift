//
//  HomeViewController.swift
//  1UpTo
//
//  Created by MJ Norona on 7/24/17.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBAction func signOutButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = GIDSignIn.sharedInstance().currentUser
        welcomeLabel.text = "Welcome, \(currentUser?.profile.name! ?? "")"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
