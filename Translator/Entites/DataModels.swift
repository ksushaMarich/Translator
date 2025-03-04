//
//  MainEntity.swift
//  Translator
//
//  Created by Ксения Маричева on 30.01.2025.
//

import Foundation
import CoreData

typealias SelectedLanguages = (source: Language, target: Language)

enum DestinationLanguage {
    
    case source, target
    
    var header: String {
        switch self {
        case .source: "Source sanguage"
        case .target: "Translation language"
        }
    }
}

#warning("Добваила функцию description(), что бы можно было получать полные называния языка, а не сокращенные")
enum Language: String {
    case en, ru, es
    
    func description() -> String {
            switch self {
            case .en:
                return "English"
            case .ru:
                return "Russian"
            case .es:
                return "Spanish"
        }
    }
}

// Send
struct YTModel: Encodable {
    var sourceLanguageCode: String
    var targetLanguageCode: String
    let format: String = "PLAIN_TEXT"
    let texts: [String]
    var folderId: String = "b1gkevc7bgt7hpu0vfln"
    var speller: Bool = true
}

// Response
struct YTranslateResponse: Decodable {
    let translations: [Translation]
}

struct Translation: Decodable {
    let text: String
}

// Error
enum APIError: Error {
    case invalidURL
    case badData
    case serverError
    case decodingError
}

@objc(QueryTranslation)
public class QueryTranslation: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<QueryTranslation> {
        NSFetchRequest<QueryTranslation>(entityName: "QueryTranslation")
    }
    
    @NSManaged public var original: String
    @NSManaged public var translation: String
    
    @NSManaged public var sourceRaw: String
    @NSManaged public var targetRaw: String
    
    var source: Language {
        get { Language(rawValue: sourceRaw) ?? .en }
        set { sourceRaw = newValue.rawValue }
    }
        
    var target: Language {
        get { Language(rawValue: targetRaw) ?? .en }
        set { targetRaw = newValue.rawValue }
    }
}
