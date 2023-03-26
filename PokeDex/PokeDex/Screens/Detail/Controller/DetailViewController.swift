//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Eymen Varilci on 25.03.2023.
//

import UIKit
import Kingfisher


final class DetailViewController: UIViewController {
    
    // MARK: UI PROPERTIES
    
    private let viewModel: DetailViewModel
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    var name : String? {
        didSet {
            self.title = name
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var pokeImage: UIImageView = {
        let iv = UIImageView()
        
        return iv
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
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var abilitySecond: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 15)
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewModel.delegate = self
        //   viewModel.fetchAbilityDescription(from: "keen-eye")
    }
    
    // MARK: CONFIGURE UI METHODS
    private func configureUI() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(pokeImage)
        view.addSubview(abilityFirst)
        view.addSubview(abilitySecond)
        view.addSubview(abilityTitle)
        
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
            make.trailing.equalToSuperview().inset(-16)
            make.height.equalTo(70)
        }
        
        abilitySecond.snp.makeConstraints { make in
            make.top.equalTo(abilityFirst.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(-16)
            make.height.equalTo(70)
        }
        
    }
    
    func setImages( url: URL) {
        self.pokeImage.kf.setImage(with: url)
    }
}



extension DetailViewController: DetailViewModelDelegate {
    func fetchedAbilities(name: [String], description: [String]) {
        guard let first = name.first else {return}
        guard let second = name.last else {return}
        
        guard let firstDescription = description.first else {return}
        guard let secondDescription = description.last else {return}
        
        self.abilityFirst.text = "\(first):  \(firstDescription)"
        self.abilitySecond.text = "\(second): \(secondDescription)"
        
        
    }
    
    func fetchFailed(error: Error) {
        print("ERROR CATCHED IN DETAIL VC: \(error.localizedDescription)")
    }
}
