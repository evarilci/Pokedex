//
//  ContainerView.swift
//  PokeDex
//
//  Created by Eymen Varilci on 24.03.2023.
//

import UIKit

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
        label.font = UIFont(name: "Helvetica", size: 25)
        return label
    }()
    
//    private lazy var abel: UILabel = {
//       let label = UILabel()
//        label.textAlignment = .left
//        label.font = UIFont(name: "Helvetica", size: 25)
//        return label
//    }()
    
    init(frame: CGRect, nameLabel: String, image: UIImage) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(image: UIImage) {
        addSubview(pokeImageView)
        pokeImageView.image = image
        NSLayoutConstraint.activate([
            pokeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            pokeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            pokeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            pokeImageView.widthAnchor.constraint(equalTo: pokeImageView.heightAnchor)
        
        ])
        pokeImageView.layer.cornerRadius = pokeImageView.frame.height / 5
    }
}
