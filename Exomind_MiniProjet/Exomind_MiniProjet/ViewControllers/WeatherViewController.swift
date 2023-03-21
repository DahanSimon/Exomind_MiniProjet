//
//  WeatherViewController.swift
//  Exomind_MiniProjet
//
//  Created by Simon Dahan on 21/03/2023.
//

import Foundation
import UIKit

class WeatherViewController: UIViewController {
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    //MARK: - Methods
    
    func setupView() {
        view.backgroundColor = .red
        
        NSLayoutConstraint.activate([])
    }
}
