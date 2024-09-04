//
//  DetailsInteractor.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

protocol DetailsBusinessLogic {
    func process(request: Details.Request)
}

protocol DetailsDataStore {
    var characterID: Int? { get set }
}

final class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore {
    
    // MARK: - Clean Components
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorker?
    
    // MARK: - DataStore
    var characterID: Int?
    
    // MARK: - BusinessLogic
    func process(request: Details.Request) {
        switch request {
        case .viewDidLoad:
            fetchCharacterDetails()
        }
    }
    
    private func fetchCharacterDetails() {
        guard let characterID = characterID else {
            return
        }
        
        worker?.fetchCharacterDetails(characterID: characterID) { [weak self] result in
            switch result {
            case .success(let character):
                self?.presenter?.present(response: .presentCharacterDetails(character))
            case .failure(let error):
                print("Error fetching character details: \(error)")
            }
        }
    }
}
