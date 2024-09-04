//
//  DetailsViewController.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

protocol DetailsDisplayLogic: AnyObject {
    func display(viewModel: Details.ViewModel)
}

import UIKit

final class DetailsViewController: UIViewController, DetailsDisplayLogic {

    // MARK: - Clean Components
    var interactor: DetailsBusinessLogic?
    var router: (DetailsRoutingLogic & DetailsDataPassing)?

    private let characterID: Int
    
    // MARK: - UI Components
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let statusLabel = UILabel()
    private let speciesLabel = UILabel()
    private let genderLabel = UILabel()
    private let originLabel = UILabel()
    private let locationLabel = UILabel()
    
    // MARK: - Init
    init(characterID: Int) {
        self.characterID = characterID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        router?.routeToCharacterDetails(characterID: characterID)
        interactor?.process(request: .viewDidLoad)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        characterImageView.contentMode = .scaleToFill
        characterImageView.clipsToBounds = true
        characterImageView.layer.cornerRadius = 25
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        nameLabel.textAlignment = .center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        statusLabel.font = UIFont.systemFont(ofSize: 18)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        speciesLabel.font = UIFont.systemFont(ofSize: 18)
        speciesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        genderLabel.font = UIFont.systemFont(ofSize: 18)
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        
        originLabel.font = UIFont.systemFont(ofSize: 18)
        originLabel.translatesAutoresizingMaskIntoConstraints = false
        
        locationLabel.font = UIFont.systemFont(ofSize: 18)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(characterImageView)
        view.addSubview(nameLabel)
        view.addSubview(statusLabel)
        view.addSubview(speciesLabel)
        view.addSubview(genderLabel)
        view.addSubview(originLabel)
        view.addSubview(locationLabel)

        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            characterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 300),
            characterImageView.widthAnchor.constraint(equalToConstant: 400),
            
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            speciesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            speciesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            genderLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 10),
            genderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            originLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 10),
            originLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            originLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            locationLabel.topAnchor.constraint(equalTo: originLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    // MARK: - DisplayLogic
    
    func display(viewModel: Details.ViewModel) {
        switch viewModel {
        case .displayCharacterDetails(let characterDetailViewModel):
            if let url = URL(string: characterDetailViewModel.imageURL) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.characterImageView.image = image
                        }
                    }
                }
            }
            
            nameLabel.text = characterDetailViewModel.name
            statusLabel.text = "Status: \(characterDetailViewModel.status)"
            speciesLabel.text = "Species: \(characterDetailViewModel.species)"
            genderLabel.text = "Gender: \(characterDetailViewModel.gender)"
            originLabel.text = "Origin: \(characterDetailViewModel.origin)"
            locationLabel.text = "Location: \(characterDetailViewModel.location)"
        }
    }

}
