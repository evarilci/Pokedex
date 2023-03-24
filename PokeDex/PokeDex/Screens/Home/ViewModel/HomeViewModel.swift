//
//  HomeViewModel.swift
//  PokeDex
//
//  Created by Eymen Varilci on 24.03.2023.
//

import Foundation
import Moya



protocol HomeViewModelDelegate: AnyObject {
    func fetchPokemonSucceed()
    func fetchPokemonFailed(_: Error)
}

protocol HomeViewModelProtocol{
    var delegate: HomeViewModelDelegate? { get set }
    func fetchPokemons()
    func numberOfRows() -> Int
    
}

final class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewModelDelegate?
    var pokemon : Pokemon? {
        didSet {
            self.delegate?.fetchPokemonSucceed()
        }
    }
    func fetchPokemons() {
        provider.request(.getPokemons) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                do {
                    let pokemons = try JSONDecoder().decode(Pokemon.self, from: response.data)
                    self.pokemon = pokemons
                    self.delegate?.fetchPokemonSucceed()
                } catch  {
                    self.delegate?.fetchPokemonFailed(error)
                    print("DOCA FAIL: \(error.localizedDescription)")
                }
            case.failure(let error):
                self.delegate?.fetchPokemonFailed(error)
                print("CASE.FAILURE \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRows() -> Int {
        return pokemon?.results?.count ?? 20
    }
    
}


