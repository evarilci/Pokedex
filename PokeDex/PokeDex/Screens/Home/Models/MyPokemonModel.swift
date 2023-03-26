//
//  MyPokemonModel.swift
//  PokeDex
//
//  Created by Eymen Varilci on 26.03.2023.
//

import UIKit


struct MyPokemonModel {
    let name: String
    let firstAbility: String
    let lastAbility: String
    let image : UIImage
    
    init(data: [String : Any]) {
        self.name = data[K.CoreData.name] as! String
        self.firstAbility = data[K.CoreData.AbilityFirst] as! String
        self.lastAbility = data[K.CoreData.AbilitySecond] as! String
        self.image = data[K.CoreData.image] as! UIImage
        
    }
    
}
