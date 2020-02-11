//
//  NetworkServices.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper

//struct CardsApIClient {
//    static func fetchCards(completion: @escaping (Result<[Card], AppError>) -> ()) {
//        
//        let endpointURLString = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
//        guard let url = URL(string: endpointURLString) else {
//            completion(.failure(.badURL(endpointURLString)))
//            return
//        }
//        let request = URLRequest(url: url)
//        NetworkHelper.shared.performDataTask(with: request) {(result) in
//            
//            switch result {
//            case .failure(let appError):
//                completion(.failure(.networkClientError(appError)))
//            case .success(let data):
//                do {
//                    let structOfCards = try JSONDecoder().decode(StructOfCards.self, from: data)
//                    completion(.success(structOfCards.cards))
//                } catch {
//                    completion(.failure(.decodingError(error)))
//                }
//            }
//        }
//    }
//}
//
