//
//  MenuViewController.swift
//  Outer Space
//
//  Created by Matheus Andrade on 08/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet var configButton: UIButton!
    @IBOutlet weak var backgroundMenu: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        backgroundMenu.translatesAutoresizingMaskIntoConstraints = false
//
//        backgroundMenu.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        backgroundMenu.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        backgroundMenu.heightAnchor.constraint(equalToConstant: self.view.frame.height*1.05).isActive = true
//        backgroundMenu.widthAnchor.constraint(equalToConstant: self.view.frame.width*1.05).isActive = true
                
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func touchConfigButton() {
        print("Touch up config button")
        
        let configView = storyboard?.instantiateViewController(identifier: "ConfigViewController") as! ConfigViewController
        self.present(configView, animated: true, completion: nil)

    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        guard sender.view != nil else { return }
        
        print("Start from tap")
        
        let transportView = storyboard?.instantiateViewController(identifier: "TransportViewController") as! TransportViewController
        self.present(transportView, animated: true, completion: nil)
    }
}

