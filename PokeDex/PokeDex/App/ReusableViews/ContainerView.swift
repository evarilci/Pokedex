////
////  ContainerView.swift
////  PokeDex
////
////  Created by Eymen Varilci on 24.03.2023.
////
//
//import UIKit
//
//final class ContainerView: UIView {
//   
//    private lazy var pokeImageView: UIImageView = {
//       let iv = UIImageView()
//        iv.clipsToBounds = true
//        iv.translatesAutoresizingMaskIntoConstraints = false
//      return iv
//    }()
//    
//    private lazy var nameLabel: UILabel = {
//       let label = UILabel()
//        label.textAlignment = .left
//        label.font = .boldSystemFont(ofSize: 20)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//
//    
//    init(frame: CGRect = .zero, nameLabel: String, image: UIImage) {
//        super.init(frame: frame)
//        configureUI(image: image, label: nameLabel)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configureUI(image: UIImage, label: String) {
//        addSubview(pokeImageView)
//        addSubview(nameLabel)
//        pokeImageView.image = image
//        NSLayoutConstraint.activate([
//            pokeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
//            pokeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
//            pokeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
//            pokeImageView.widthAnchor.constraint(equalTo: pokeImageView.heightAnchor),
//        
//            nameLabel.leadingAnchor.constraint(equalTo: pokeImageView.trailingAnchor, constant: 16),
//            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
//            nameLabel.heightAnchor.constraint(equalToConstant: 50),
//            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
//     
//        ])
//        pokeImageView.layer.cornerRadius = pokeImageView.frame.height / 5
//        pokeImageView.image = image
//        nameLabel.text = label
//        self.backgroundColor = .systemGray6
//        self.translatesAutoresizingMaskIntoConstraints = false
//    }
//}
