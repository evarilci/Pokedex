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
            super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    lazy var abilityTitle: UILabel = {
      let label = UILabel()
       label.textAlignment = .left
       label.font = .boldSystemFont(ofSize: 20)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
     lazy var abilityFirst: UILabel = {
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
        viewModel.delegate = self
    }
    
    // MARK: CONFIGURE UI METHODS
    func configureUI() {
        view.backgroundColor = .systemGray6
        self.title = nameLabel.text
        view.addSubview(pokeImage)
        view.addSubview(abilityFirst)
        view.addSubview(abilityTitle)
        view.addSubview(nameLabel)
        abilityTitle.text = "Abilities"
        pokeImage.snp.makeConstraints { make in
            make.top.equalToSuperview { view in
                view.safeAreaLayoutGuide
            }
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(pokeImage.snp.width)
        }
        abilityTitle.snp.makeConstraints { make in
            make.top.equalTo(pokeImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(40)
        }
        
        
        abilityFirst.snp.makeConstraints { make in
            make.top.equalTo(abilityTitle.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(view.snp.centerX)
            make.height.equalTo(30)
        }
        
        
        
        
    }
    
    func setImages( url: URL) {
        self.pokeImage.kf.setImage(with: url)
    }
}



extension DetailViewController: DetailViewModelDelegate {
    func fetchedAbilities(name: String) {
    
        self.abilityFirst.text = "\(name): "
    }
    
    func fetchFailed(error: Error) {
        print("ERROR CATCHED IN DETAIL VC: \(error.localizedDescription)")
    }
    
    
}
