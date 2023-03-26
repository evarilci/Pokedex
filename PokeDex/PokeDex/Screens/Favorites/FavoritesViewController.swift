//
//  FavoritesViewController.swift
//  PokeDex
//
//  Created by Eymen Varilci on 26.03.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(fetchPokemon().last?.name)
    }
    
}


extension FavoritesViewController : CoreDataReachable {
    
}
