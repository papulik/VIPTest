//
//  DetailsPresenter.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

protocol DetailsPresentationLogic {
    func present(response: Details.Response)
}

final class DetailsPresenter: DetailsPresentationLogic {

    // MARK: - Clean Components

    weak var viewController: DetailsDisplayLogic?

    // MARK: - PresentationLogic
    
    func present(response: Details.Response) {
        switch response {
        case .presentCharacterDetails(let character):
            let viewModel = Details.CharacterDetailViewModel(
                id: character.id,
                name: character.name,
                status: character.status,
                species: character.species,
                gender: character.gender,
                origin: character.origin.name,
                location: character.location.name,
                imageURL: character.image
            )
            
            DispatchQueue.main.async {
                self.viewController?.display(viewModel: .displayCharacterDetails(viewModel))
            }
        }
    }
}
