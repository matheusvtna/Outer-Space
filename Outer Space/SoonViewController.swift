//
//  SoonViewController.swift
//  Outer Space
//
//  Created by Samuel Brasileiro on 01/07/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import UIKit

class SoonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func gitButton(_ sender: UIButton) {
        let webURL = URL(string: "https://github.com/matheusvtna/Outer-Space")!
        UIApplication.shared.open(webURL)
    }
    

}
