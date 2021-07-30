//
//  CardsStorage.swift
//  FINCH Test
//
//  Created by Arthur Raff on 26.07.2021.
//

import UIKit

public final class Card: Codable {
    public var title: String
    public var description: String
    public var preview: Data

    public init(title: String, description: String, preview: Data) {
        self.title = title
        self.description = description
        self.preview = preview
    }
}

public final class CardsStore {
    public static let shared: CardsStore = .init()
    public var cards: [Card] = [] {
        didSet {
            save()
        }
    }
    private lazy var userDefaults: UserDefaults = .standard
    private lazy var decoder: JSONDecoder = .init()
    private lazy var encoder: JSONEncoder = .init()
    
    private init() {
        if userDefaults.value(forKey: "start_date") == nil {
            userDefaults.setValue(Date(), forKey: "start_date")
        }
        
        guard let data = userDefaults.data(forKey: "cards") else { return }
        
        do {
            cards = try decoder.decode([Card].self, from: data)
        }
        catch {
            print("Ошибка декодирования сохранённых карточек", error)
        }
    }
    
    public func save() {
        do {
            let data = try encoder.encode(cards)
            userDefaults.setValue(data, forKey: "cards")
        }
        catch {
            print("Ошибка кодирования карточек для сохранения", error)
        }
    }
}

extension Card: Equatable {
    public static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.title == rhs.title &&
        lhs.description == rhs.description &&
        lhs.preview == rhs.preview
    }
}
