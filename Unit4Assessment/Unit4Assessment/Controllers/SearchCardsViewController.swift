//
//  SearchCradsViewController.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchCardsViewController: UIViewController {
    
    private let searchCardsView = SearchCardsView()
    
    //FIXME:
    // public var dataPersistenec: DataPersistence<
    
    override func loadView() {
        view = searchCardsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        navigationItem.title = "Search Card"
    }

}
