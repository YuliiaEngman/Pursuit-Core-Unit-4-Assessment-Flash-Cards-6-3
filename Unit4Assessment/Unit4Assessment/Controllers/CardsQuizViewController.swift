//
//  CardsViewController.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CardsQuizViewController: UIViewController {
    
    private let cardsView = CardsView()
    
    //FIXME:
    // public var dataPersistenec: DataPersistence<Article>!

    override func loadView() {
        view = cardsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        navigationItem.title = "Cards Quiz"
    }

}
