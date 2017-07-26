//
//  MemoriesViewController.swift
//  1UpTo
//
//  Created by Yi-Jui, Chiu on 25/07/2017.
//  Copyright © 2017 MJ Norona. All rights reserved.
//

import UIKit

class MemoriesViewController: UIViewController {
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.target = revealViewController()
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name : "Main", bundle : nil)
        let destController = mainStoryboard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        present(destController, animated: true, completion: nil)
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
