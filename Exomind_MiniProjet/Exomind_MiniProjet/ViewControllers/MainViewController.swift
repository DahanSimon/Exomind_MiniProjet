//
//  MainViewController.swift
//  Exomind_MiniProjet
//
//  Created by Simon Dahan on 21/03/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Views
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "system", size: 14.0)
        label.textColor = .black
        label.text = "Welcome"
        return label
    }()
    
    lazy var startButton: UIButton = {
        var tintedConfiguration = UIButton.Configuration.tinted()
        tintedConfiguration.title = "Start"
        tintedConfiguration.image = UIImage(systemName: "play.fill")
        tintedConfiguration.imagePlacement = .trailing
        tintedConfiguration.imagePadding = 5.0
        
        let button = UIButton(configuration: tintedConfiguration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180.0).isActive = true
        button.setTitle("Start", for: .normal)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(welcomeLabel)
        stackView.addArrangedSubview(startButton)
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20.0
        return stackView
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    //MARK: - Methods
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        welcomeLabel.text = "Bienvenue"
    }
    
    //MARK: - Actions
    @objc func startButtonTapped() {
        let weatherViewController = WeatherViewController()
        navigationController?.pushViewController(weatherViewController, animated: true)
    }
}
