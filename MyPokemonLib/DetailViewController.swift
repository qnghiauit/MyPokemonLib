//
//  DetailViewController.swift
//  MyPokemonLib
//
//  Created by Quang Nghia on 5/12/17.
//  Copyright © 2017 Quang Nghia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var imgPokemon: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbDefence: UILabel!
    @IBOutlet weak var lbHeight: UILabel!
    @IBOutlet weak var lbPokeID: UILabel!
    @IBOutlet weak var lbWeight: UILabel!
    @IBOutlet weak var lbAttack: UILabel!
    @IBOutlet weak var imgNextLevel1: UIImageView!
    @IBOutlet weak var imgNextLevel2: UIImageView!
    @IBOutlet weak var lbEvolution: UILabel!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
