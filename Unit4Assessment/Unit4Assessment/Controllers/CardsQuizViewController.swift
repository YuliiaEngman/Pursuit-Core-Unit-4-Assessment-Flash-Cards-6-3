//
//  CardsViewController.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence


class CardsQuizViewController: UIViewController {
    
    private let cardsView = CardsView()
    
    public var dataPersistence: DataPersistence<Card>!
    
    // data for our collection view
    private var cards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.cardsView.collectionView.reloadData()
            }
        }
    }
    
    override func loadView() {
        view = cardsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        navigationItem.title = "Card Quiz"
        
        cardsView.collectionView.dataSource = self
        cardsView.collectionView.delegate = self
        
        cardsView.collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        
        loadData()
    }
    
    func loadData() {
        cards = Card.getCards()
    }
}

extension CardsQuizViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardCell else {
            fatalError("could not downcast to CardCell")
        }
        let card = cards[indexPath.row]
        cell.configureCell(with: card)
        //FIXME: remove cell color
        cell.backgroundColor = .blue
        cell.delegate = self
        return cell
    }
}

extension CardsQuizViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension CardsQuizViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was saved")
        //FIXME:
        // fetchSavedArticles() // using it to test
        
    }
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("item was deleted")
        //FIXME:
        //fetchSavedArticles()
    }
}

extension CardsQuizViewController: CardCellDelegate {
    func didSelectMoreActionsButton(_ cardCell: CardCell, card: Card) {
        print("didSelectMoreActionsButton: \(card.quizTitle)")
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            UIAlertAction in
            self.deleteCard(card)
        }
        
        alertController.addAction(cancelAction)
        
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true)
    }
    
    private func deleteCard(_ card: Card) {
        guard let index = cards.firstIndex(of: card) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            print("error deleting card: \(error)")
        }
    }
}




