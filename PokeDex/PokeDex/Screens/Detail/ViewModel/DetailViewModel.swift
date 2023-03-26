//
//  DetailViewModel.swift
//  PokeDex
//
//  Created by Eymen Varilci on 26.03.2023.
//

import UIKit
import Moya


protocol DetailViewModelDelegate: AnyObject {
    func fetchedAbilities(name: String, url: String)
    func fetchFailed(error: Error)
}

protocol DetailViewModelProtocol {
    var delegate : DetailViewModelDelegate? {get set}
    func fetchDetails()
}


final class DetailViewModel: DetailViewModelProtocol {
    var delegate: DetailViewModelDelegate?
    var spec : Ability?
    var abilityResponse : [Ability]? {
        didSet{
            print(abilityResponse?.count)
        }
    }
    
    func fetchDetails() {
        
        guard let ability = spec?.ability?.name else {return}
        provider.request(.getPokemonDetails(text: ability)) {[weak self] result in
            
            switch result {
            case .success(let response):
                do {
                    let ability = try JSONDecoder().decode(Ability.self, from: response.data)
                  //  self?.delegate?.fetchedAbilities(name: ability.ability?.name, url: <#T##String#>)
                    self?.abilityResponse?.append(ability)
                } catch  {
                    self?.delegate?.fetchFailed(error: error)
                }
                print("")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
