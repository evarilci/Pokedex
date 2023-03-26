//
//  FavoritesCollectionViewCell.swift
//  PokeDex
//
//  Created by Eymen Varilci on 26.03.2023.
//

import UIKit

final class FavoritesCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.backgroundColor = .systemGray4
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = self.frame.height / 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(name: String, image: UIImage) {
        addSubview(imageView)
        addSubview(nameLabel)
        imageView.image = image
        nameLabel.text = name
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().inset(4)
            make.top.equalToSuperview().offset(4)
            make.height.equalTo(imageView.snp.width)
        }
        imageView.layer.cornerRadius = self.layer.cornerRadius - 4
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(4)
        }
        
        
    }
    
    
    
}
