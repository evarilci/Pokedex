//
//  NavBarView.swift
//  PokeDex
//
//  Created by Eymen Varilci on 25.03.2023.
//

import UIKit

final class BarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView()
        imageView.image =  UIImage(named: K.logo)!
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

