//
//  MainModels.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

enum Main {
    
    // MARK: - Interactor
    
    enum Request {
        case viewDidLoad
        case selectCharacter(id: Int)
    }
    
    // MARK: - Presenter
    
    enum Response {
        case presentCharacters([Character])
        case presentCharacterDetails(Character)
    }
    
    // MARK: - ViewController
    
    enum ViewModel {
        case displayCharacters([CharacterViewModel])
    }
    
    // MARK: - Router
    
    enum RoutingDestination {
        case showCharacterDetail(id: Int)
    }
    
    // MARK: - Shared Models
    
    struct Character: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let gender: String
        let origin: Origin
        let location: Location
        let image: String
    }

    struct Origin: Decodable {
        let name: String
        let url: String
    }

    struct Location: Decodable {
        let name: String
        let url: String
    }

    
    struct CharacterViewModel {
        let id: Int
        let name: String
        let imageURL: String
    }
    
}
