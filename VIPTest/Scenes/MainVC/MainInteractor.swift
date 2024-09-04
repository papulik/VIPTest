//
//  MainInteractor.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

protocol MainBusinessLogic {
    func process(request: Main.Request)
}

protocol MainDataStore {
    var characters: [Main.Character]? { get }
}

final class MainInteractor: MainBusinessLogic, MainDataStore {
    
    // MARK: - Clean Components
    
    var presenter: MainPresentationLogic?
    var worker: MainWorker?
    
    // MARK: - DataStore
    var characters: [Main.Character]?
    
    // MARK: - BusinessLogic
    
    func process(request: Main.Request) {
        switch request {
        case .viewDidLoad:
            fetchCharacters()
        case .selectCharacter(id: let id):
            if let character = characters?.first(where: { $0.id == id }) {
                presenter?.present(response: .presentCharacterDetails(character))
            }
        }
    }
    
    private func fetchCharacters() {
        worker?.fetchCharacters { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                self?.presenter?.present(response: .presentCharacters(characters))
            case .failure(let error):
                print("Failed to fetch characters: \(error.localizedDescription)")
            }
        }
    }
}
