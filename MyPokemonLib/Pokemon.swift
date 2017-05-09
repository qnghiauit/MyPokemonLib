//
//  Pokemon.swift
//  MyPokemonLib
//
//  Created by Quang Nghia on 5/10/17.
//  Copyright © 2017 Quang Nghia. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name : String!
    private var _id : Int!
    
    var name : String {
        return _name
    }
    var id : Int {
        return _id
    }
    
    init(name: String, id: Int) {
        self._name = name
        self._id = id
    }
}
