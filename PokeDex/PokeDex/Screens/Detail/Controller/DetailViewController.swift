//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Eymen Varilci on 25.03.2023.
//

import UIKit
import Kingfisher


final class DetailViewController: UIViewController {
    
    // MARK: PROPERTIES
    
    private let viewModel: DetailViewModel
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    lazy var pokeImage: UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    
    
     lazy var nameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var abilitiesLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 15)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    
    // MARK: LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: CONFIGURE UI METHODS
    func configureUI() {
        view.addSubview(pokeImage)
        view.addSubview(nameLabel)
        view.addSubview(abilitiesLabel)
        pokeImage.snp.makeConstraints { make in
            make.top.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(pokeImage.snp.width)
        }
        
        
        
        
    }
}
