//
//  DetailViewModel.swift
//  PokeDex
//
//  Created by Eymen Varilci on 26.03.2023.
//

import UIKit
import Moya


protocol DetailViewModelDelegate: AnyObject {
    func fetchedAbilities(name: [String], description: [String])
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
            
        }
    }
    var abilityResponse : [AbilityAbility]?
    
    func fetchDetails(for ability: [AbilityElement]){
        var abilityNames = [String]()
        var detailedAbilities = [String]()
        for i in ability {
            provider.request(.getPokemonDetails(text: (i.ability?.name)!)) {[weak self] result in
                switch result {
                case .success(let response):
                    do {
                        let ability = try JSONDecoder().decode(AbilityAbility.self, from: response.data)
                        let detailedAbility = try JSONDecoder().decode(AbilitySelf.self, from: response.data)
                        for j in detailedAbility.effectEntries! where j.language?.name == "en" {
                            detailedAbilities.append(j.effect ?? "N/A")
                            print("------------------------------\(detailedAbilities.description)")
                        }
                       
                        abilityNames.append(ability.name ?? "N/A")
                        self?.delegate?.fetchedAbilities(name: abilityNames, description: detailedAbilities)
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
}
