//
//  HomeViewCell.swift
//  PokeDex
//
//  Created by Eymen Varilci on 24.03.2023.
//

import UIKit

final class HomeViewCell: UITableViewCell {
    
    var pokemon : Result? {
        didSet {
            // TODO: configure components
        }
    }
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
