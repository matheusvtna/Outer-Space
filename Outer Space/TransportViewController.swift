//
//  TransportViewController.swift
//  Outer Space
//
//  Created by Matheus Andrade on 08/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import UIKit

class TransportViewController: UIViewController{
    
    
    @IBOutlet var planetaTutorial: UIButton!
    @IBOutlet var planetaLaranja: UIButton!
    @IBOutlet var planetaFogoGelo: UIButton!
    @IBOutlet var planetaRoxo: UIButton!
    @IBOutlet var planetaTerra: UIButton!
    @IBOutlet var label: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var onda1: UIImageView!
    @IBOutlet var onda2: UIImageView!
    @IBOutlet var onda3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Planeta longe demais!"
        label.isHidden = true
        animateRadar()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    func animateRadar() {
        self.onda1.alpha = 0.1
        self.onda2.alpha = 0.1
        self.onda3.alpha = 0.1
        
        UIImageView.animate(withDuration: 0.7, delay: 1.0, animations: {
            self.onda1.alpha = 1
        }, completion: { (value: Bool) in
            UIImageView.animate(withDuration: 0.7,
                                animations: {
                                    self.onda1.alpha = 0.1
                                    self.onda2.alpha = 1
            },completion: { _ in
                UIButton.animate(withDuration: 0.7, animations:  {
                    self.onda2.alpha = 0.1
                    self.onda3.alpha = 1
                },completion: {_ in
                    UIButton.animate(withDuration: 0.7){
                        self.onda3.alpha = 0.1
                        self.animateRadar()
                    }
                })
            })
        })
    }
    
    @IBAction func touchBackButton() {
        print("Touch up back button - Transport")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchPlanet(_ sender: UIButton) {
        
        if(sender == planetaTutorial){
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
