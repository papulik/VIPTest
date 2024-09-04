//
//  MainViewController.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

protocol MainDisplayLogic: AnyObject {
    func display(viewModel: Main.ViewModel)
}

final class MainViewController: UIViewController, MainDisplayLogic {
    
    //MARK: - UI Components
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Clean Components
    
    var interactor: MainBusinessLogic?
    var router: (MainRoutingLogic & MainDataPassing)?
    private var characters: [Main.CharacterViewModel] = []
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.process(request: .viewDidLoad)
        
        SetupUI()
    }
    
    //MARK: - UI Setup
    
    private func SetupUI() {
        view.backgroundColor = .white
        title = "Rick&Morty VIP"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(tableView)
        //Subs:
        tableView.delegate = self
        tableView.dataSource = self
        //register cell:
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - DisplayLogic
    
    func display(viewModel: Main.ViewModel) {
        switch viewModel {
        case .displayCharacters(let characterViewModels):
            self.characters = characterViewModels
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let character = characters[indexPath.row]
        cell.nameLabel.text = character.name
        
        
        if let imageUrl = URL(string: character.imageURL) {
            fetchImage(from: imageUrl) { image in
                DispatchQueue.main.async {
                    if tableView.indexPath(for: cell) == indexPath {
                        cell.characterImageView.image = image
                    }
                }
            }
        } else {
            cell.characterImageView.image = UIImage(systemName: "person.fill")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = characters[indexPath.row]
        router?.navigate(to: .showCharacterDetail(id: selectedCharacter.id), animated: true)
    }
    
    private func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                completion(nil)
                return
            }
            completion(image)
        }
        task.resume()
    }
    
}
