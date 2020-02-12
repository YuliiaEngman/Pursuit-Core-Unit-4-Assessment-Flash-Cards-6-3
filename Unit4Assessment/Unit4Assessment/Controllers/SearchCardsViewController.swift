//
//  SearchCradsViewController.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchCardsViewController: UIViewController {
    
    private let searchCardsView = SearchCardsView()
    
    public var dataPersistence: DataPersistence<Card>!
    
    //Custom Delegation: Step 4 out of 6 (conform variable, even if you have didSet with it bellow
    var card: Card?
    
    // data for our collection view
       private var cards = [Card]() {
           didSet {
               DispatchQueue.main.async {
            self.searchCardsView.collectionView.reloadData()
               }
           }
       }
    
    override func loadView() {
        view = searchCardsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        navigationItem.title = "Search Card"
        
        searchCardsView.collectionView.dataSource = self
        searchCardsView.collectionView.delegate = self
        
        searchCardsView.searchBar.delegate = self
        
        searchCardsView.collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "searchCell")
        
        //fetchCards()
        loadData()
    }
    
    func loadData() {
        cards = Card.getCards()
    }
    
//    @objc func addButtonPressed(_ sender: UIButton) {
//       guard let card = card else { return }
//        do {
//            try dataPersistence.createItem(card)
//            print("card was created")
//        } catch {
//            print("error saving card \(error)")
//        }
//    }
}

//Custom Delegation: Step 5 out of 6
extension SearchCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not downcast to SearchCell")
        }
        let card = cards[indexPath.row]
        cell.configureCell(for: card)
        cell.delegate = self
        //FIXME: remove cell color
        cell.backgroundColor = .yellow
        return cell
    }
}

extension SearchCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if searchCardsView.searchBar.isFirstResponder {
            searchCardsView.searchBar.resignFirstResponder()
        }
    }
}

extension SearchCardsViewController: UISearchBarDelegate {
    //changes while typing
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        guard !searchText.isEmpty else {
            //fetchCards()
            loadData()
            return
        }
        cards = cards.filter { ($0.quizTitle!.lowercased().contains(searchText.lowercased()))}
    }
}

//Custom Delegation: Step 6 out of 6
extension SearchCardsViewController: SearchCellDelegate {
    func didSelectAddButton(_ searchCell: SearchCell, card: Card) {
        do {
            try dataPersistence.createItem(card)
            print("card created")
            self.showAlert(title: "Saved", message: "Card was saved")
        } catch {
            print("error saving card \(error)")
        }
       // print(card.quizTitle)
    }
}

extension SearchCardsViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
