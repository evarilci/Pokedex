////
////  ContainerView.swift
////  PokeDex
////
////  Created by Eymen Varilci on 24.03.2023.
////

import UIKit
import Kingfisher

final class ContainerView: UIView {
   
    private lazy var pokeImageView: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
      return iv
    }()
    
    private lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteMoveLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 15)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    init(frame: CGRect = .zero, nameLabel: String, imageURL: URL, favoriteLabel: String) {
        super.init(frame: frame)
        configureUI(imageURL: imageURL, label: nameLabel, favoriteLabel: favoriteLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(imageURL: URL, label: String, favoriteLabel: String) {
        addSubview(pokeImageView)
        addSubview(nameLabel)
        addSubview(favoriteMoveLabel)
        self.backgroundColor = .systemGray4
            NSLayoutConstraint.activate([
            pokeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            pokeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            pokeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            pokeImageView.widthAnchor.constraint(equalTo: pokeImageView.heightAnchor),
        
            nameLabel.leadingAnchor.constraint(equalTo: pokeImageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            favoriteMoveLabel.leadingAnchor.constraint(equalTo: pokeImageView.trailingAnchor, constant: 16),
            favoriteMoveLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            favoriteMoveLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -8),
            favoriteMoveLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8)
            
     
        ])
        pokeImageView.layer.cornerRadius = pokeImageView.frame.height / 5
        pokeImageView.kf.setImage(with: imageURL)
        nameLabel.text = label
        favoriteMoveLabel.text = favoriteLabel
        self.backgroundColor = .systemGray6
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
