//
//  FavoritesViewController.swift
//  PokeDex
//
//  Created by Eymen Varilci on 26.03.2023.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: PROPERTIES
    private var collectionView : UICollectionView!
    lazy var pokemonArr = fetchPokemon()
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
       
    }
    
    func configureUI() {
         let width = view.frame.size.width
         let height = view.frame.size.height
        view.backgroundColor = .systemGray6
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: width / 2 - 20, height: height / 3 - 50)
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: K.FavoritesCellID)
        
        view.addSubview(collectionView)
    }
    
}
// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemonArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.FavoritesCellID, for: indexPath) as! FavoritesCollectionViewCell
            let pokemon = pokemonArr[indexPath.row]
        cell.configureCell(name: pokemon.name, image: pokemon.image)
        return cell
    }
   
}

extension FavoritesViewController : CoreDataReachable {
    
}
