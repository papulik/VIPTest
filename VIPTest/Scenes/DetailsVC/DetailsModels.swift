//
//  DetailsModels.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

enum Details {
    
    // MARK: - Interactor
    
    enum Request {
        case viewDidLoad
    }
    
    // MARK: - Presenter
    
    enum Response {
        case presentCharacterDetails(Character)
    }
    
    // MARK: - ViewController
    
    enum ViewModel {
        case displayCharacterDetails(CharacterDetailViewModel)
    }
    
    // MARK: - Router
    
    enum RoutingDestination {
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
    
    struct CharacterDetailViewModel {
        let id: Int
        let name: String
        let status: String
        let species: String
        let gender: String
        let origin: String
        let location: String
        let imageURL: String
        
        init(id: Int, name: String, status: String, species: String, gender: String, origin: String, location: String, imageURL: String) {
            self.id = id
            self.name = name
            self.status = status
            self.species = species
            self.gender = gender
            self.origin = origin
            self.location = location
            self.imageURL = imageURL
        }
    }

}
