//
//  CreateViewController.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//


//TODO: Setup texfield + 2 Text views
import UIKit
import DataPersistence

class CreateCardsViewController: UIViewController {
    
    private let createCardView = CreateCardView()
    
    public var dataPersistence: DataPersistence<Card>!
    
    private var cards = [Card]()
    
    // private var createdCard: Card!
    
    
    override func loadView() {
        view = createCardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        navigationItem.title = "Create Card"
        
        createCardView.textField.delegate = self
        createCardView.textView1.delegate = self
        createCardView.textView2.delegate = self
        
        //FIXME: insert correct function
        // programmatically setting up the right UIBarBarItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createNewCardButtonPressed(_:)))
    }
    
    @objc
    func createNewCardButtonPressed(_ sender: UIBarButtonItem) {
        
        let createdCard = Card(id: "", quizTitle: createCardView.textField.text, facts: [createCardView.textView1.text, createCardView.textView2.text])
        
        
        if createdCard.facts!.count <= 1 {
            self.showAlert(title: "Add Facts", message: "The Quiz requires two facts")
        } else if createdCard.quizTitle?.isEmpty == true {
        self.showAlert(title: "Add Title", message: "Title is required")
        } else {
            
            do {
                try dataPersistence.createItem(createdCard)
                print("card was created")
            } catch {
                print("error saving card \(error)")
            }
        }
        
           createCardView.textField.text = ""
           createCardView.textView1.text = ""
           createCardView.textView2.text = ""
    }
}

extension CreateCardsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension CreateCardsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
    }
}

extension CreateCardsViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


