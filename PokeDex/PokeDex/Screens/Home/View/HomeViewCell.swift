//
//  HomeViewCell.swift
//  PokeDex
//
//  Created by Eymen Varilci on 24.03.2023.
//

import UIKit
import Kingfisher

final class HomeViewCell: UITableViewCell {
    
//    var pokemon : Result? {
//        didSet {
//           configureConteiner(for: pokemon!)
//        }
//    }
//
    private lazy var pokeImageView: UIImageView = {
       let iv = UIImageView()
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
      return iv
    }()
    
    private  var nameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureConteiner(for result: Result, url: URL? = nil, favorite move: String) {
        
        guard let name = result.name else {return}
        
        let container = ContainerView(nameLabel: name, imageURL: url!, favoriteLabel: "Favorite move: \(move)")
        container.layer.cornerRadius = self.frame.height / 2
        addSubview(container)
        container.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
        
        self.nameLabel.text = name
        self.pokeImageView.kf.setImage(with: url)
    }

}
