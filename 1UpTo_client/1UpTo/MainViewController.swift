//
//  ViewController.swift
//  1UpTo
//
//  Created by MJ Norona on 7/24/17.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var signInButton: GIDSignInButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let currentUser = GIDSignIn.sharedInstance().currentUser
        print("Welcome, \(currentUser?.profile.name! ?? "")")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindLogout(segue: UIStoryboardSegue) {
        GIDSignIn.sharedInstance().signOut()
    }


}

