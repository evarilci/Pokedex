//
//  DetailViewController.swift
//  PokeDex
//
//  Created by Eymen Varilci on 25.03.2023.
//

import UIKit
import Kingfisher
import Toast


final class DetailViewController: UIViewController {
    
    var name : String? {
        didSet {
            self.title = name
        }
    }
    
    // MARK: VIEWMODEL INJECTION
    private let viewModel: DetailViewModel
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI PROPERTIES
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
    }
    // MARK: OBJC METHODS
    
    @objc func addFavoritesAction() {
        guard let name = self.title, let first = abilityFirst.text, let second = abilitySecond.text else {return}
        guard let image = self.pokeImage.image else {return}
        self.savePokemonToFavorites(name: name, abilityFirst: first, abilitySecond: second, image: image) { string in
            self.showToast(subtitle: string)
        }
    }
    
    func showToast(subtitle: String) {
        let toast = Toast.default(
            image: UIImage(systemName: "checkmark.seal.fill")!,
            title: "Done!",
            subtitle: subtitle,
            config: .init(direction: .top, autoHide: true, enablePanToClose: true, displayTime: 3, animationTime: 0.2, enteringAnimation: .default, exitingAnimation: .default, attachTo: nil)
        )
        toast.show()
    }
    
    
    // MARK: CONFIGURE UI METHODS
    private func configureUI() {
        view.backgroundColor = .systemGray6
        view.addSubview(pokeImage)
        view.addSubview(abilityFirst)
        view.addSubview(abilitySecond)
        view.addSubview(abilityTitle)
        let barButton = UIBarButtonItem(image: UIImage(systemName: "heart.circle"), style: .done, target: self, action: #selector(addFavoritesAction))
        self.navigationItem.rightBarButtonItem = barButton
        
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
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(70)
        }
        
        abilitySecond.snp.makeConstraints { make in
            make.top.equalTo(abilityFirst.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(70)
        }
    }
    
    func setImages( url: URL) {
        self.pokeImage.kf.setImage(with: url)
    }
}
// MARK: DetailViewModelDelegate
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

// MARK: CoreDataReachable
extension DetailViewController: CoreDataReachable {
    
}
