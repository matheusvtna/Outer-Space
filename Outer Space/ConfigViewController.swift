//
//  ConfigViewController.swift
//  Outer Space
//
//  Created by Matheus Andrade on 08/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController{
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var switchSounds: UISwitch!
    @IBOutlet var switchMusic: UISwitch!
    @IBOutlet weak var portal: UIImageView!
    @IBOutlet weak var textura: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetButton.backgroundColor = .clear
        resetButton.layer.cornerRadius = 18
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.red.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIImageView.animate(withDuration: 10.0, delay: 1.0, options: [.repeat, .autoreverse], animations: {
            self.rotateAnimation(imageView: self.portal)
            self.portal.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            
        }
        UIImageView.animate(withDuration: 30.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.textura.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            
        }) { _ in
            
        }
    }
    
    func rotateAnimation(imageView: UIImageView,duration: CFTimeInterval = 40.0) {
        let rotate = CABasicAnimation(keyPath: "transform.rotation")
        rotate.fromValue = 0.0
        rotate.toValue = CGFloat.pi * 2
        rotate.duration = duration
        rotate.repeatCount = .greatestFiniteMagnitude
        
        imageView.layer.add(rotate, forKey: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    @IBAction func touchBackButton() {
        print("Touch up back button - Config")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchResetButton() {
        alerta(msg: "Você perderá todo o progresso construído até aqui. Você tem certeza que deseja resetar o jogo?")
    }
    
    @IBAction func changeSwitch(_ sender: UISwitch) {
        if(sender == switchMusic){
            print("Music is \(switchMusic.isOn)")
        }
        else{
            print("Sound is \(switchSounds.isOn)")
        }
    }
    
    func alerta(msg: String){
        let alerta = UIAlertController(title: "Alerta", message: msg, preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        { (UIAlertAction) in
            self.resetGame()
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil)
        
        alerta.addAction(cancel)
        alerta.addAction(ok)
        self.present(alerta, animated: true, completion: nil)
    }
    
    func resetGame(){
        print("Game reseted")
    }
    
}
