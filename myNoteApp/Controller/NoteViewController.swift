//
//  NoteViewController.swift
//  myNoteApp
//
//  Created by ДаблЧери on 5/23/19.
//  Copyright © 2019 CAT&GIRL. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController, UITextFieldDelegate,  UINavigationControllerDelegate {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var noteText: UITextField!
    

    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    var notesFetchedResultsController: NSFetchedResultsController<Note>!
    var notes = [Note]()
    var note: Note?
    var isExsisting = false
    var indexPath: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.noteText.becomeFirstResponder()
        if let note = note {
            noteText.text = note.details
        }
        
        if noteText.text != "" {
            isExsisting = true
        }
        
        noteText.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        if noteText.text == ""{
            let alertController = UIAlertController(title: "Заметка пуста", message:"Введите данные.", preferredStyle: UIAlertController.Style.alert)
            let OKAction = UIAlertAction(title: "Назад", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            if (isExsisting == false) {
                let textOfNote = noteText.text
                
                if let moc = managedObjectContext {
                    let note = Note(context: moc)
                    
                    
                    note.details = textOfNote
                    
                    saveToCoreData() {
                        
                        let isPresentingInAddFluidPatientMode = self.presentingViewController is UINavigationController
                        
                        if isPresentingInAddFluidPatientMode {
                            self.dismiss(animated: true, completion: nil)
                            
                        } else {
                            self.navigationController!.popViewController(animated: true)
                            
                        }
                        
                    }
                    
                }
                
            } else if (isExsisting == true) {
                let note = self.note
                let managedObject = note
                managedObject!.setValue(noteText.text, forKey: "details")
               
                do {
                    try context.save()
                    let isPresentingInAddFluidPatientMode = self.presentingViewController is UINavigationController
                    
                    if isPresentingInAddFluidPatientMode {
                        self.dismiss(animated: true, completion: nil)
                        
                    } else {
                        self.navigationController!.popViewController(animated: true)
                        
                    }
                    
                } catch {
                    print("Failed to update existing note.")
                }
            }
            
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
            }
        return true
    }
    
    func saveToCoreData(completion: @escaping ()->Void){
        managedObjectContext!.perform {
            do {
                try self.managedObjectContext?.save()
                completion()
                print("Note saved to CoreData.")
                
            } catch let error {
                print("Could not save note to CoreData: \(error.localizedDescription)")
                
            }
            
        }
        
    }
    
}
