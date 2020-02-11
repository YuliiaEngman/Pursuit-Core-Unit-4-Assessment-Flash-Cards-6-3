//
//  CreateViewController.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateCardsViewController: UIViewController {
    
    private let createCardView = CreateCardView()
    
    //FIXME:
    public var dataPersistence: DataPersistence<Card>!
    
    override func loadView() {
        view = createCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        navigationItem.title = "Create Card"
    }

}
