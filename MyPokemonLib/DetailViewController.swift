//
//  DetailViewController.swift
//  MyPokemonLib
//
//  Created by Quang Nghia on 5/12/17.
//  Copyright © 2017 Quang Nghia. All rights reserved.
//

import UIKit
import Alamofire

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
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var ctsWidthImageNextEvo: NSLayoutConstraint!
    @IBOutlet weak var vImgNextEvo: UIView!
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadPokeData()
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func reloadUI() {
        self.lbName.text = pokemon.name!
        self.lbType.text = pokemon.type!
        self.lbDefence.text = "\(pokemon.defense!)"
        self.lbHeight.text = "\(pokemon.height!)"
        self.lbPokeID.text = "\(pokemon.id!)"
        self.lbWeight.text = "\(pokemon.weight!)"
        self.lbAttack.text = "\(pokemon.attack!)"
        
        let currentLevelImg = UIImage(named: "\(pokemon.id!)")
        self.imgPokemon.image = currentLevelImg
        self.imgNextLevel1.image = currentLevelImg
        
        if self.pokemon.nextEvolutionId != nil {
            self.lbEvolution.text = "Next Evolution: \(pokemon.nextEvolutionName!) Lv. \(pokemon.nextEvolutionLevel!)"
            self.imgNextLevel2.image = UIImage(named: "\(pokemon.nextEvolutionId!)")
        } else {
            self.lbEvolution.text = "Next Evolution: None"
            self.imgNextLevel2.isHidden = true
        }

    }
    
    func downloadPokeData() {
        let ApiUrl = "http://pokeapi.co/api/v1/pokemon/\(pokemon.id!)/"
        print(ApiUrl)
        Alamofire.request(ApiUrl).responseJSON { respond in
            if let result = respond.result.value as? Dictionary<String,AnyObject> {
                if let name = result["name"] as? String {
                    self.pokemon.name = name
                }
                if let defense = result["defense"] as? Int {
                    self.pokemon.defense = defense
                }
                if let attack = result["attack"] as? Int {
                    self.pokemon.attack = attack
                }
                if let height = result["height"] as? String {
                    self.pokemon.height = Int(height)!
                }
                if let weight = result["weight"] as? String {
                    self.pokemon.weight = Int(weight)!
                }
                if let types = result["types"] as? [Dictionary<String,AnyObject>] {
                    var type = String()
                    if let type0 = types[0]["name"] as? String {
                        type = type0.capitalized
                    }
                    if types.count > 1 {
                        if let type1 = types[1]["name"] as? String {
                            type.append("/\(type1.capitalized)")
                        }
                    }
                    self.pokemon.type = type
                }
                if let descArr = result["descriptions"] as? [Dictionary<String, AnyObject>] , descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let descURL = "http://pokeapi.co\(url)"
                        print(descURL)
                        Alamofire.request(descURL).responseJSON { (response) in
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descDict["description"] as? String {
                                    print(description)
                                    self.pokemon.description = description
                                }
                            }
                            self.lbDescription.text = self.pokemon.description!
                        }
                    }
                }
                if let evolutions = result["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                            self.pokemon.nextEvolutionName = nextEvo
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                self.pokemon.nextEvolutionId = Int(nextEvoId)!
                                if let lvlExist = evolutions[0]["level"] {
                                    if let lvl = lvlExist as? Int {
                                        self.pokemon.nextEvolutionLevel = lvl
                                    }
                                } else {
                                    
                                    self.pokemon.nextEvolutionLevel = -1
                                }
                            }
                        }
                    }
                }
            }
            self.reloadUI()
        }
    }
    
}
