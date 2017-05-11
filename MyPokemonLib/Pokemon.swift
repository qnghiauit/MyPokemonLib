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
        get {
            return _name
        }
        set(value) {
            _name = value
        }
    }
    var id : Int {
        get {
            return _id
        }
        set(value) {
            _id = value
        }
    }
    
    init(name: String, id: Int) {
        self._name = name
        self._id = id
    }
    
    init() { }
}
