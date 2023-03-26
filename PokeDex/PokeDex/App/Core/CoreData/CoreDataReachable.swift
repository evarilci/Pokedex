//
//  CoreDataReachable.swift
//  PokeDex
//
//  Created by Eymen Varilci on 26.03.2023.
//

import UIKit
import CoreData


protocol CoreDataReachable where Self: UIViewController {
    
}

extension CoreDataReachable {
    
    func savePokemonToFavorites(name: String, abilityFirst: String, abilitySecond: String, image: UIImage, completion: @escaping(String) -> Void) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let existingPokemons = try context.fetch(fetchRequest)
            if let _ = existingPokemons.first {
                completion("Pokemon Exists")
                print("This pokemon has already been added to favorites")
                return
            }
            let pokemon = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context)
            let data = image.jpegData(compressionQuality: 1)
            pokemon.setValue(name, forKey: K.CoreData.name)
            pokemon.setValue(abilityFirst, forKey: K.CoreData.AbilityFirst)
            pokemon.setValue(abilitySecond, forKey: K.CoreData.AbilitySecond)
            pokemon.setValue(data, forKey: K.CoreData.image)
            try context.save()
            print("SAVE SUCCEED")
            completion("Pokemon added to favorites")
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
    
    func fetchPokemon() -> [MyPokemonModel] {
        var arr = [MyPokemonModel]()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: K.CoreData.Entity)
        fetchRequest.returnsObjectsAsFaults = false
     
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                let name = result.value(forKey: K.CoreData.name) as! String
                let firstAbility = result.value(forKey: K.CoreData.AbilityFirst) as! String
                let secondAbility = result.value(forKey: K.CoreData.AbilitySecond) as! String
                let data = result.value(forKey: K.CoreData.image) as! Data
                let image = UIImage(data: data)
                let dict : [String : Any] = [K.CoreData.name : name, K.CoreData.AbilityFirst : firstAbility, K.CoreData.AbilitySecond : secondAbility, K.CoreData.image: image!]
                let poke = MyPokemonModel(data: dict)
                arr.append(poke)
                
            }
        } catch  {
            
        }
        return arr
    }
    
}
