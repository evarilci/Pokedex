//
//  HomeViewController.swift
//  PokeDex
//
//  Created by Eymen Varilci on 23.03.2023.
//

import UIKit
import Moya

final class HomeViewController: UIViewController {
        let viewModel = HomeViewModel()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        viewModel.delegate = self
        viewModel.fetchPokemons()
    }


}

extension HomeViewController: HomeViewModelDelegate {
    func fetchPokemonSucceed() {
        print("fetch succeed")
    }
    
    func fetchPokemonFailed(_: Error) {
        
    }
    
    
}
