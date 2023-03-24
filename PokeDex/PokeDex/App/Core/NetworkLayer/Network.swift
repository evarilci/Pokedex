//
//  Network.swift
//  PokeDex
//
//  Created by Eymen Varilci on 24.03.2023.
//
import Foundation
import Moya

let plugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
let provider = MoyaProvider<PokeApi>(plugins: [plugin])


enum PokeApi{
    case getPokemons
    case getPokemonImage(text: String)
    
}

extension PokeApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2")!
    }
    
    var path: String {
        switch self {
        case .getPokemons:
            return "/pokemon/?limit=30"
        case .getPokemonImage(text: let text):
            return "/pokemon/\(text)"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getPokemons:
            return .requestPlain
        case.getPokemonImage:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
