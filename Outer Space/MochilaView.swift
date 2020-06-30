//
//  MochilaView.swift
//  Outer Space
//
//  Created by Evaldo Garcia de Souza Júnior on 29/06/20.
//  Copyright © 2020 Matheus Andrade. All rights reserved.
//
import UIKit

class MyViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public let fundo = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 414))
    public let collectionView = UICollectionView(frame: CGRect(x: 10, y: 60, width: 280, height: 354), collectionViewLayout: UICollectionViewFlowLayout())
    public let header = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        fundo.backgroundColor = .black
        //header
        header.text = "ITENS RECUPERADOS"
        header.font = UIFont(name: "Nexa Bold", size: 18)
        header.backgroundColor = .white
        header.textAlignment = .center
        header.textColor = .black
        header.layer.masksToBounds = true
        header.layer.cornerRadius = 8
        header.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        //collectionVIew
        collectionView.register(ContoCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        collectionView.backgroundColor = .black
    
        view.addSubview(fundo)
        view.addSubview(collectionView)
        view.addSubview(header)
        self.view = view
    }
    
    override func viewDidLoad() {
           collectionView.delegate = self
           collectionView.dataSource = self
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ContoCollectionViewCell
        //cell?.backgroundColor = .green
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 258, height: 105)
    }
}


public class ContoCollectionViewCell: UICollectionViewCell {
    public let titulo = UILabel(frame: CGRect(x: 105, y: 18, width: 150, height: 15))
    public let descricao = UILabel(frame: CGRect(x: 105, y: 35, width: 150, height: 60))
    public let icon = UIImageView(frame: CGRect(x: 5, y: 10, width: 75, height: 90))

    public override init(frame: CGRect){
        super.init(frame:frame)
        //titulo
        titulo.text = "Bilola de Brennand"
        titulo.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titulo.font = UIFont(name: "Nexa Bold", size: 14)
        //descricao
        descricao.text = "cu de \"Tese\" o mais importante é expor a ideia central sobre o tema de maneira clara. Importante lembrar que a Introdução é a parte mais importante do texto e por isso deve conter a informações que logo serão desenvolvidas."
        descricao.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        descricao.numberOfLines = 5
        descricao.font = UIFont(name: "Nexa Light", size: 12)
        //icon
        icon.image = UIImage(named: "bilola.png")

        self.addSubview(icon)
        self.addSubview(descricao)
        self.addSubview(titulo)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
