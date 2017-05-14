//
//  Pokemon.swift
//  MyPokemonLib
//
//  Created by Quang Nghia on 5/10/17.
//  Copyright © 2017 Quang Nghia. All rights reserved.
//

import Foundation

class Pokemon {
    var name : String!
    var id : Int!
    var type : String!
    var defense : Int!
    var height : Int!
    var weight : Int!
    var attack : Int!
    var description : String!
    var nextEvolutionName : String!
    var nextEvolutionLevel : Int!
    var nextEvolutionId : Int!
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    init() { }
}
