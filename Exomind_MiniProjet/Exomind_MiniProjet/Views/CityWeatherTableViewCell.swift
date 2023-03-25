//
//  CityWeatherTableViewCell.swift
//  Exomind_MiniProjet
//
//  Created by Simon Dahan on 24/03/2023.
//

import Foundation
import UIKit

class CityWeatherTableViewCell: UITableViewCell {
    
    //MARK: -Properties
    
    let iconURL: String
    
    // MARK: - Views
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "system", size: 14.0)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "system", size: 14.0)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(weatherIcon)
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20.0
        return stackView
    }()
    
    // MARK: - Initializers
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, iconURL: String) {
        self.iconURL = iconURL
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupView() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0)
        ])
        
        if let iconURL = URL(string: iconURL) {
            weatherIcon.load(url: iconURL)
        }
        stackView.insertArrangedSubview(weatherIcon, at: 0)
    }
}
