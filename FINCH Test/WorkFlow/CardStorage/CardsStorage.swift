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
    public var preview: String
    public var date: Date
    public var dateString: String {
        "Создано" + dateFormatter.string(from: date)
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    private lazy var calendar: Calendar = .current

    public init(title: String, description: String, preview: String, date: Date) throws {
        self.title = title
        self.description = description
        self.date = date
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
    
    public var dates: [Date] {
        guard let startDate = userDefaults.object(forKey: "start_date") as? Date else {
            return []
        }
        return Date.dates(from: startDate, to: .init())
    }
    
    private lazy var userDefaults: UserDefaults = .standard
    
    private lazy var decoder: JSONDecoder = .init()
    
    private lazy var encoder: JSONEncoder = .init()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ru")
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    private lazy var calendar: Calendar = .current
    
    private init() {
        if userDefaults.value(forKey: "start_date") == nil {
            userDefaults.setValue(Date(), forKey: "start_date")
        }
        guard let data = userDefaults.data(forKey: "cards") else {
            return
        }
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
        lhs.preview == rhs.preview &&
        lhs.date == rhs.date
    }
}

private extension Date {
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate

        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else {
                break
            }
            date = newDate
        }
        return dates
    }
}
