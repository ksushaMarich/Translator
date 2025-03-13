//
//  CoreDataManager.swift
//  Core Data
//
//  Created by Ксюша on 16.02.2025.
//

import UIKit
import CoreData

// MARK: - CRUD
public final class CoreDataManager: NSObject {
    
    public static let shared = CoreDataManager()
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    func saveTranslation(original: String, translation: String, languages: SelectedLanguages) {
        let queryTranslation = QueryTranslation(context: context)
        queryTranslation.original = original
        queryTranslation.translation = translation
        queryTranslation.source = languages.source
        queryTranslation.target = languages.target
        appDelegate.saveContext()
    }
    
    func fetchTranslations() -> [QueryTranslation] {
        (try? context.fetch(QueryTranslation.fetchRequest())) ?? []
    }
    
    func deleteTranslations() {
        fetchTranslations().forEach { context.delete($0)}
        appDelegate.saveContext()
    }
}
