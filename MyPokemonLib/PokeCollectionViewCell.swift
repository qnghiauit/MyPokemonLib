//
//  PokeCollectionViewCell.swift
//  MyPokemonLib
//
//  Created by Quang Nghia on 5/10/17.
//  Copyright © 2017 Quang Nghia. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgThumbail: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func fillData(_ pokemon: Pokemon) {
        self.pokemon = pokemon
        lbName.text = pokemon.name.capitalized
        self.imgThumbail.image = UIImage(named: "\(self.pokemon.id!)")
    }
}
