//
//  CardModel.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation


//struct StructOfCards: Codable & Equatable {
//    let cardListType: String
//    let apiVersion: String
//    let cards: [Card]
//}

struct Card: Codable & Equatable {
    let id: String?
    var quizTitle: String?
    var facts: [String]?
}

extension Card {
    static func getCards() -> [Card] {
        var cards = [Card]()

        guard let fileURL = Bundle.main.url(forResource: "cardsDataFile", withExtension: "json") else {
            fatalError("could not locate json file")
        }
        do {
        let data = try Data(contentsOf: fileURL)

        let cardsData = try JSONDecoder().decode([Card].self, from: data)
        cards = cardsData
        } catch {
           fatalError("failed to load contents \(error)")
        }
        return cards
    }
}
