//
//  MainRouter.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import UIKit

protocol MainRoutingLogic {
    func navigate(to destination: Main.RoutingDestination, animated: Bool)
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get set }
}

final class MainRouter: MainRoutingLogic, MainDataPassing {
    
    // MARK: - Clean Components
    
    weak var viewController: MainViewController?
    var dataStore: MainDataStore?
    
    // MARK: - RoutingLogic
    
    func navigate(to destination: Main.RoutingDestination, animated: Bool) {
        switch destination {
            
        case .showCharacterDetail(id: let id):
            let detailVC = DetailsViewController(characterID: id)
            
            DetailsConfigurator.configure(viewController: detailVC)
            
            viewController?.navigationController?.pushViewController(detailVC, animated: animated)
        }
    }
}
