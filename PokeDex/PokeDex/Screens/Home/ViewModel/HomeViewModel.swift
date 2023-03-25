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
    func fetchPokemonDetails(text: String)
    func numberOfRows() -> Int
    func pokemonFor(row at: Int) -> Result
    func fetchPhotoForRow(at index: Int) -> URL
    
    
}

final class HomeViewModel: HomeViewModelProtocol {
    weak var delegate: HomeViewModelDelegate?
    var pokemon : Pokemon? {
        didSet {
          //  self.delegate?.fetchPokemonSucceed()
            if (pokemon?.results!.count)! > 0 {
                self.delegate?.fetchPokemonSucceed()
            }
        }
    }
    
    var singlePokemonSpec = [Spesifications]() {
        didSet {
            print("******** specs come")
            print(singlePokemonSpec.count)
          
        }
    }
    
    // MARK: FETCH 20 POKEMONS METHOD.
    func fetchPokemons() {
        provider.request(.getPokemons) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let response):
                do {
                    let pokemons = try JSONDecoder().decode(Pokemon.self, from: response.data)
                    self.pokemon = pokemons
                    
                    pokemons.results?.forEach({ i in
                        self.fetchPokemonDetails(text: i.name ?? "ivysaur")
                    })
                } catch  {
                    self.delegate?.fetchPokemonFailed(error)
                    print("DOCA FAIL: \(error.localizedDescription)")
                }
                self.delegate?.fetchPokemonSucceed()
                
            case.failure(let error):
                self.delegate?.fetchPokemonFailed(error)
                print("CASE.FAILURE \(error.localizedDescription)")
            }
            
        }
    }
    
    // MARK: FETCH POKEMONS DETAILS AS WELL AS IMAGE.
    func fetchPokemonDetails(text: String) {
        provider.request(.getPokemonImage(text: text)) { result in
            switch result {
            case .success(let response):
                do {
                    let specs = try JSONDecoder().decode(Spesifications.self, from: response.data)
                    self.singlePokemonSpec.append(specs)
                } catch  {
                    print("SPEC FETCH DOCA ERROR: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("SPEC FETCH FAIL CASE ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRows() -> Int {
        //pokemon!.results!.count
        singlePokemonSpec.count
    }
    
    func pokemonFor(row at: Int) -> Result {
           pokemon!.results![at]
      
    }
    
    func fetchPhotoForRow(at index: Int) -> URL {
        if let url = URL(string: (singlePokemonSpec[index].sprites?.frontDefault!)!) {
            return url
        } else {
            return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-vi/omegaruby-alphasapphire/20.png")!
        }
        
      
    }
    
}


