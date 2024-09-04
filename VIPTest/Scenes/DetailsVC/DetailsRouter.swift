//
//  DetailsRouter.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

protocol DetailsRoutingLogic {
    func routeToCharacterDetails(characterID: Int)
}

protocol DetailsDataPassing {
    var dataStore: DetailsDataStore? { get }
}

final class DetailsRouter: DetailsRoutingLogic, DetailsDataPassing {
    
    // MARK: - Clean Components
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
    
    // MARK: - Routing Logic
    func routeToCharacterDetails(characterID: Int) {
        dataStore?.characterID = characterID
    }
}
