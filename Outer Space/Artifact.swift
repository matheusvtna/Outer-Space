//
//  Artifact.swift
//  Outer Space
//
//  Created by Samuel Brasileiro on 01/07/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//

import Foundation
import UIKit
class Artifact{

    let name: String
    let description: String
    let image: UIImage?
    
    private var found: Bool
    
    public var isFound: Bool{
        get {found}
    }
    
    init(name: String, description: String, imageName: String){
        self.name = name
        self.description = description
        self.image = UIImage(named: imageName)
        self.found = false
    }
    
    func find(){
        found = true
    }
    
}
class ArtifactBank{
    var artifacts: [Artifact] = []
    
    init(){
        artifacts.append(Artifact(name: "Mochila", description: "A sua companheira mochila, sem ela você não conseguiria pular nessa atmosfera! Cuide muito bem dela.", imageName: "mochila"))
        artifacts.append(Artifact(name: "Cogumelo Flambante", description: "Que raridade! Alguns povos de Kaateena matariam pelos efeitos desse cogumelo psicodélico. É comestível!", imageName: "cogumelo"))
        artifacts.append(Artifact(name: "Orbe Singelo", description: "O seu primeiro orbe, que te acompanha desde o começo. Mas ele é um pouco simples, não é? Talvez...", imageName: "orbe"))
    }
    
    func foundArtifacts()->[Artifact]{
        return artifacts.filter{ $0.isFound }
    }
}
