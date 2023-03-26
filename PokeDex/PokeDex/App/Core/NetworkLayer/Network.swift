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
    case getPokemonDetails(text: String)
    //added for testing purposes
    case getclefairy
}

extension PokeApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://pokeapi.co/api/v2")!
    }
    
    var path: String {
        switch self {
        case .getPokemons:
            return "/pokemon/"
        case .getPokemonImage(text: let text):
            return "/pokemon/\(text)/"
        case .getPokemonDetails(text: let text):
            return "/ability/\(text)"
            //added for testing purposes
        case .getclefairy:
            return "/pokemon/clefairy/"
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
        case .getPokemonDetails:
            return .requestPlain
        case.getclefairy:
            return.requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
}
