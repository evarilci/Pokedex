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
    func fetchPokemonFailed(error: Error)
}

protocol HomeViewModelProtocol{
    var delegate: HomeViewModelDelegate? { get set }
    func fetchPokemons()
    func fetchPokemonDetails(text: String)
    func numberOfRows() -> Int
    func pokemonFor(row at: Int) -> Result
    func fetchPhotoForRow(at index: Int) -> URL
    func getFavorite(at index: Int) -> String
    func getSpecForDetail(at row: Int) -> AbilityAbility
}

final class HomeViewModel: HomeViewModelProtocol {
   
    
    weak var delegate: HomeViewModelDelegate?
    var pokemon : Pokemon? 
    
    var singlePokemonSpec = [Spesifications]() {
        didSet {
            self.delegate?.fetchPokemonSucceed()
            
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
                    self.delegate?.fetchPokemonFailed(error: error)
                }
                self.delegate?.fetchPokemonSucceed()
                
            case.failure(let error):
                self.delegate?.fetchPokemonFailed(error: error)
            }
        }
    }
    // MARK: FETCH POKEMONS DETAILS AS WELL AS IMAGE.
    func fetchPokemonDetails(text: String) {
        provider.request(.getPokemonImage(text: text)) {[weak self] result in
            switch result {
            case .success(let response):
                do {
                    let specs = try JSONDecoder().decode(Spesifications.self, from: response.data)
                    self?.singlePokemonSpec.append(specs)
                } catch  {
                    self?.delegate?.fetchPokemonFailed(error: error)
                }
            case .failure(let error):
                self?.delegate?.fetchPokemonFailed(error: error)
            }
        }
    }
    
    func numberOfRows() -> Int {
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
    
    func getFavorite(at index: Int) -> String {
        guard let favorite = singlePokemonSpec[index].moves![0].move?.name else {
            let another = "N/A"
            return another
        }
        return favorite
    }
    
    func getSpecForDetail(at row: Int) -> AbilityAbility {
        let ability = singlePokemonSpec[row].abilities?.first?.ability
       
        return ability!
    }
}


