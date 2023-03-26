//
//  DetailViewModel.swift
//  PokeDex
//
//  Created by Eymen Varilci on 26.03.2023.
//

import UIKit
import Moya


protocol DetailViewModelDelegate: AnyObject {
    func fetchedAbilities(name: String)
    func fetchFailed(error: Error)
}

protocol DetailViewModelProtocol {
    var delegate : DetailViewModelDelegate? {get set}
    func fetchDetails(for ability: [AbilityElement])
}


final class DetailViewModel: DetailViewModelProtocol {
    var delegate: DetailViewModelDelegate?
    var spec :[AbilityElement]? {
        didSet {
            self.fetchDetails(for: spec!)
            print("SPECS:\(spec?.count) ")
        }
    }
    var abilityResponse : [AbilityAbility]?
       
    
    
    func fetchDetails(for ability: [AbilityElement]){
        for i in ability {
            provider.request(.getPokemonDetails(text: (i.ability?.name)!)) {[weak self] result in
                switch result {
                case .success(let response):
                    do {
                        let ability = try JSONDecoder().decode(AbilityAbility.self, from: response.data)
                        self?.delegate?.fetchedAbilities(name: ability.name ?? "N/A")
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
        
//        provider.request(.getPokemonDetails(text: (ability.ability?.name!)!)) {[weak self] result in
//            switch result {
//            case .success(let response):
//                do {
//                    let ability = try JSONDecoder().decode(AbilityAbility.self, from: response.data)
//                    self?.delegate?.fetchedAbilities(name: ability.name ?? "N/A")
//                    self?.abilityResponse?.append(ability)
//                } catch  {
//                    self?.delegate?.fetchFailed(error: error)
//                }
//                print("")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
}
