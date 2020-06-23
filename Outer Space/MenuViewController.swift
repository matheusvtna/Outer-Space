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
    @IBOutlet weak var nomeLogo: UIImageView!
    @IBOutlet weak var portalLogo: UIImageView!
    @IBOutlet weak var textura: UIImageView!
    @IBOutlet weak var toque: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tap)
        
        UIImageView.animate(withDuration: 1.5, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.nomeLogo.transform = CGAffineTransform(scaleX: 1.06, y: 1.06)
        }) { _ in
            
        }
        UIImageView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.toque.alpha = 0.3
            self.toque.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }) { _ in
            
        }
        UIImageView.animate(withDuration: 30.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.textura.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            
        }) { _ in
            
        }
        
        UIImageView.animate(withDuration: 2.0, delay: 1.0, options: [.repeat, .autoreverse], animations: {
            self.rotateAnimation(imageView: self.portalLogo)
            self.portalLogo.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    func rotateAnimation(imageView: UIImageView,duration: CFTimeInterval = 30.0) {
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = 0.0
        rotate.toValue = CGFloat.pi * 2
        rotate.duration = duration
        rotate.repeatCount = .greatestFiniteMagnitude
        
        imageView.layer.add(rotate, forKey: nil)
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

