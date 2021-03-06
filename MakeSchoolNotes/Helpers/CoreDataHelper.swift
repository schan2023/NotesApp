//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Simone Chan on 7/8/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    //Creating note as NSObject
    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        return note
    }
    
    //Save notes
    static func saveNote() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    //Deletes notes
    static func delete(note: Note) {
        context.delete(note)
        
        saveNote()
    }
    
    //Retrieve notes
    static func retrieveNotes() -> [Note] {
        do {
            //Retrieves core data and sorts it by date
            let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
            let sort = NSSortDescriptor(key: #keyPath(Note.modificationTime), ascending: false)
            fetchRequest.sortDescriptors = [sort]
            
            let results = try context.fetch(fetchRequest)
            return results
        }
        catch let error {
            print("Could not fetch results")
            
            return []
        }
    }
}
