//
//  DetailsWorker.swift
//  VIPTest
//
//  Created by Zuka Papuashvili on 03.09.24.
//  Copyright (c) 2024 TBC. All rights reserved.
//

import Foundation

protocol DetailsWorkingLogic {
    func fetchCharacterDetails(characterID: Int, completion: @escaping (Result<Details.Character, Error>) -> Void)
}

final class DetailsWorker: DetailsWorkingLogic {
    
    func fetchCharacterDetails(characterID: Int, completion: @escaping (Result<Details.Character, Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character/\(characterID)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let character = try JSONDecoder().decode(Details.Character.self, from: data)
                completion(.success(character))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
