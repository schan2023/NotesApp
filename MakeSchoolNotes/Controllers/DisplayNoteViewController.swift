//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
    //Properties
    var note: Note?
    
    //Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //displays notes and populates text field and text view
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note {
            titleTextField.text = note.title
            contentTextView.text = note.content
        } else {
            titleTextField.text = ""
            contentTextView.text = ""
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
            //receives segue from ListNotesTableViewController
            //must type cast to access 'notes' array
            //Passing from DisplayNoteView to ListNotesTableView
            let destination = segue.destination as? ListNotesTableViewController
            else { return }
        
        switch identifier {
        //saves new notes
        case "save" where note != nil:
            //edits and saves edited note
            //optional bc it could be edited or not edited
            note?.title = titleTextField.text ?? ""
            note?.content = contentTextView.text ?? ""
            note?.modificationTime = Date()
            
            CoreDataHelper.saveNote()
            
        case "save" where note == nil:
            //creates new note and adjusts note title and content when displaying note
            let note = CoreDataHelper.newNote()
            note.title = titleTextField.text ?? ""
            note.content = contentTextView.text ?? ""
            note.modificationTime = Date()
            
            //appends new note to notes array
            CoreDataHelper.saveNote()
            
        case "cancel":
            print("cancel button was tapped")
        default:
            print("unexpected segue identifier")
        }
    }
    
}
