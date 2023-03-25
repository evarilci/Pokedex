//
//  SplashScreen.swift
//  PokeDex
//
//  Created by Eymen Varilci on 25.03.2023.
//

import UIKit

final class SplashScreen: UIView {
    
    let splashImage : UIImageView = {
    let iv = UIImageView()
        iv.image = UIImage(named: K.logo)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    func configureUI() {
        addSubview(splashImage)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray6
        NSLayoutConstraint.activate([
            splashImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            splashImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            splashImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            splashImage.heightAnchor.constraint(equalTo: splashImage.widthAnchor, multiplier: 0.4)
            
            
            
        ])
    }
    
    
}
