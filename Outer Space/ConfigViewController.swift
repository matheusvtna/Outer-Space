//
//  ConfigViewController.swift
//  Outer Space
//
//  Created by Matheus Andrade on 08/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet var switchSounds: UISwitch!
    @IBOutlet var switchMusic: UISwitch!
    
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
