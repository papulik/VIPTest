//
//  MainPresenter.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

protocol MainPresentationLogic {
    func present(response: Main.Response)
}

final class MainPresenter: MainPresentationLogic {

    // MARK: - Clean Components

    weak var viewController: MainDisplayLogic?

    // MARK: - PresentationLogic
    
    func present(response: Main.Response) {
        switch response {
        case .presentCharacters(let characters):
            let characterViewModels = characters.map { character in
                Main.CharacterViewModel(
                    id: character.id,
                    name: character.name,
                    imageURL: character.image
                )
            }
            viewController?.display(viewModel: .displayCharacters(characterViewModels))
        default:
            break
        }
    }
}
