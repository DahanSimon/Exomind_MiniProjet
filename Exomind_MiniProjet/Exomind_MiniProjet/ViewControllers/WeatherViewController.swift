//
//  WeatherViewController.swift
//  Exomind_MiniProjet
//
//  Created by Simon Dahan on 21/03/2023.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    
    //MARK: - Variables
    
    private let viewModel = WeatherViewModel()
        
    //MARK: - Views
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "system", size: 14.0)
        label.textColor = .black
        label.numberOfLines = .zero
        label.textAlignment = .center
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = .zero
        //TODO: Remove fixed constraints to improve responsiveness across devices
        progressView.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 10.0).isActive = true
        progressView.layer.cornerRadius = 10.0
        return progressView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(progressView)
        stackView.addArrangedSubview(tableView)
        stackView.addArrangedSubview(restartButton)
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20.0
        return stackView
    }()
    
    private lazy var  tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8).isActive = true
        return tableView
    }()
    
    private lazy var restartButton: UIButton = {
        var tintedConfiguration = UIButton.Configuration.tinted()
        tintedConfiguration.title = "Restart"
        tintedConfiguration.image = UIImage(systemName: "arrow.counterclockwise")
        tintedConfiguration.imagePlacement = .trailing
        tintedConfiguration.imagePadding = 5.0
        
        let button = UIButton(configuration: tintedConfiguration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180.0).isActive = true
        button.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        viewModel.updateMessage = {[weak self] message in
            self?.setMessage(message)
        }
        
        startFetchingWeatherData()
        startMessageRotation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.reset()
    }
    
    //MARK: - Methods
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)
        
        tableView.isHidden = true
        restartButton.isHidden = true
        
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func startFetchingWeatherData() {
        viewModel.fetchWeatherData()
    }
    
    private func startMessageRotation() {
        viewModel.startMessageRotation()
    }
    
    private func setMessage(_ message: String) {
        messageLabel.text = message
    }
    
    private func updateUI() {
        let citiesCount = viewModel.cities.count
        progressView.setProgress(Float(viewModel.weatherData.count) / Float(citiesCount), animated: true)
        if citiesCount == viewModel.apiCallsCount {
            let alertTitle = viewModel.errorDescription.isEmpty ? "Success" : "Error"
            let alertMessage = viewModel.errorDescription.isEmpty ? "Datas fully downloaded" : viewModel.errorDescription
            presentAlert(message: alertMessage, title: alertTitle) { _ in
                self.showRestartButton()
            }
        }
    }
    
    private func showRestartButton() {
        progressView.isHidden   = true
        restartButton.isHidden  = false
        messageLabel.isHidden   = true
        tableView.isHidden      = false
        tableView.reloadData()
    }
    
    func reset() {
        progressView.setProgress(0, animated: false)
        
        progressView.isHidden   = false
        messageLabel.isHidden   = false
        tableView.isHidden      = true
        restartButton.isHidden  = true
        
        viewModel.reset()
        tableView.reloadData()
    }
    
    //MARK: - Actions
    
    @objc func restartButtonTapped() {
        reset()
        startFetchingWeatherData()
        startMessageRotation()
    }
    
}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = viewModel.weatherData[indexPath.row]
        let url = "https://openweathermap.org/img/w/\(weather.weather.first!.icon).png"
        let cell = CityWeatherTableViewCell(style: .default, reuseIdentifier: "cityWeatherCell", iconURL: url)
        cell.cityLabel.text = weather.name
        cell.tempLabel.text = String(weather.main.temp.rounded()) + "°C"
        
        return cell
    }
}
