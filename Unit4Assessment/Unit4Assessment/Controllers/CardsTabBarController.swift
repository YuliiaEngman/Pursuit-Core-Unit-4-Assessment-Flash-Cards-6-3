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
    
    private var dataPersistence = DataPersistence<Card>(filename: "savedCards.plist")
    
    //VC1:
    private lazy var cardsQuizViewController: CardsQuizViewController = {
        let viewController = CardsQuizViewController()
        viewController.tabBarItem = UITabBarItem(title: "Card Quiz", image: UIImage(systemName: "rectangle.grid.1x2"), tag: 0)
      
        //FIXME: add datapersistence + delegate?
        viewController.dataPersistence = dataPersistence
        viewController.dataPersistence.delegate = viewController
        return viewController
    }()
    
    //VC 2:
  private lazy var createCardsViewController: CreateCardsViewController = {
        let viewController = CreateCardsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Create Card", image: UIImage(systemName: "square.and.pencil"), tag: 1)
        viewController.dataPersistence = dataPersistence
        return viewController
    }()
    
    //VC 3:
    private lazy var searchCardsViewController: SearchCardsViewController = {
        let viewController = SearchCardsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Search Cards", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        viewController.dataPersistence = dataPersistence
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //FIXME: delete this color
        view.backgroundColor = .systemOrange
        
        viewControllers = [UINavigationController(rootViewController: cardsQuizViewController), UINavigationController(rootViewController: createCardsViewController), UINavigationController(rootViewController: searchCardsViewController)]
    }
}
