//
//  HomeViewController.swift
//  PokeDex
//
//  Created by Eymen Varilci on 23.03.2023.
//

import UIKit
import Moya

final class HomeViewController: UIViewController {
    
    // MARK: PROPERTIES
    let viewModel = HomeViewModel()
    let tableView = UITableView()
    
    // MARK: LIFECYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        viewModel.fetchPokemons()
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: K.cellIdentifier)
        setupUI()
    }
    
    // MARK: UI METHOD
    func setupUI() {
        let splashView = SplashScreen()
       
        tableView.rowHeight = 75
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(splashView)
        splashView.isHidden = false
        splashView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {[self] in
            splashView.snp.removeConstraints()
            splashView.isHidden = true
            let barView = BarView()
            self.navigationItem.titleView = barView
            view.addSubview(tableView)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            self.view.layoutIfNeeded()
        })
    }
}

// MARK:  UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! HomeViewCell
        cell.selectionStyle = .none
        let pokemon = viewModel.pokemonFor(row: indexPath.row)
        let url = viewModel.fetchPhotoForRow(at: indexPath.row)
        let favoriteMove = viewModel.getFavorite(at: indexPath.row)
        cell.configureConteiner(for: pokemon, url: url, favorite: favoriteMove)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = DetailViewModel()
        let vc = DetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
// MARK:  HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func fetchPokemonSucceed() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func fetchPokemonFailed(error: Error) {
        print(error.localizedDescription)
    }
}
