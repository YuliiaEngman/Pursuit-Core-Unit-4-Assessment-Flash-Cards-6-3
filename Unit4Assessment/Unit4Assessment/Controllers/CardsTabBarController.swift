//
//  CardsTabBarController.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence


class CardsTabBarController: UITabBarController {
    
    // FIXME:
    //private var dataPersistance = DataPersistence<Article>(filename: "savedArticles.plist")
    
    //VC1:
    private lazy var cardsQuizViewController: CardsQuizViewController = {
        let viewController = CardsQuizViewController()
        viewController.tabBarItem = UITabBarItem(title: "Cards Quiz", image: UIImage(systemName: "rectangle.grid.1x2"), tag: 0)
        //FIXME: add datapersistence + delegate?
        //viewController.dataPersistance = dataPersistance
        //viewController.dataPersistance.delegate = viewController
        return viewController
    }()
    
    private lazy var createCardsViewController: CreateCardsViewController = {
        let viewController = CreateCardsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Create Card", image: UIImage(systemName: "square.and.pensil"), tag: 1)
        //FIXME: add datapersistence
        //viewController.dataPersistance = dataPersistance
        return viewController
    }()
    
    private lazy var searchCardsViewController: SearchCradsViewController = {
        let viewController = SearchCradsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Search Cards", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        //FIXME: add datapersistence
        //viewController.dataPersistance = dataPersistance
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FIXME: delete this color
        view.backgroundColor = .systemOrange
        viewControllers = [UINavigationController(rootViewController: cardsQuizViewController), UINavigationController(rootViewController: createCardsViewController), UINavigationController(rootViewController: searchCardsViewController)]
    }
}
