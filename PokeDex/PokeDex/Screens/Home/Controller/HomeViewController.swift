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
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.setupUI()
        })
        
    }
    
    
    // MARK: UI METHOD
    func setupUI() {
        view.addSubview(tableView)
        tableView.rowHeight = 75
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK:  UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! HomeViewCell
        let pokemon = viewModel.pokemonFor(row: indexPath.row)
        let url = viewModel.fetchPhotoForRow(at: indexPath.row)
        cell.configureConteiner(for: pokemon, url: url)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
}
// MARK:  HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func fetchPokemonSucceed() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func fetchPokemonFailed(_: Error) {
        
    }
    
    
}
