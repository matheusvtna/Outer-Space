//
//  TransportViewController.swift
//  Outer Space
//
//  Created by Matheus Andrade on 08/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import UIKit

class TransportViewController: UIViewController{
    
    
    @IBOutlet var planet0: UIButton!
    @IBOutlet var planet1: UIButton!
    @IBOutlet var planet2: UIButton!
    @IBOutlet var planet3: UIButton!
    @IBOutlet var planet4: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Planeta longe demais!"
        label.isHidden = true
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func touchBackButton() {
        print("Touch up back button - Transport")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchPlanet(_ sender: UIButton) {
        
        if(sender == planet0 || sender == planet1){
            print("Toquei no planeta")
            
            let gameView = storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
            self.present(gameView, animated: true, completion: nil)
        }
        else{
            label.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.label.isHidden = true
            }
        }
        
    }
}
