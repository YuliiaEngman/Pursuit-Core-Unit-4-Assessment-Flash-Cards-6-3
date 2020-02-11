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
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        //fetchCards()
//    }
    
    //FIXME: create private func fetchCards() that searches from API and changes on every symbol
//    private func fetchCards() {
//        CardsApIClient.fetchCards{[weak self] result in
//            switch result {
//            case .failure(let appError):
//                print("error fetching cards: \(appError)")
//            case .success(let cards):
//                print("found \(cards.count) cards and expect 52 cards")
//                dump(cards)
//                self?.cards = cards
//            }
//        }
//    }
}

extension SearchCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //FIXME: cards.count
        return cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not downcast to SearchCell")
        }
        let card = cards[indexPath.row]
        cell.configureCell(with: card)
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
        cards = cards.filter { $0.quizTitle.lowercased().contains(searchText.lowercased())}
    }
}
