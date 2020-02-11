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
    
    //FIXME:
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // fetchCards()
    }
    
    //FIXME: create private func fetchCards() that searches from API and changes on every symbol
}

extension SearchCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as? SearchCell else {
            fatalError("could not downcast to SearchCell")
        }
        let card = cards[indexPath.row]
        cell.configureCell(with: card)
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
    
    //FIXME:
    // this is the way how we segue to anothr VC
//       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//           let article = newsArticles[indexPath.row]
//           let articleDVC = ArticleDetailViewController()
//
//           // TODO: after assessment we will be using initializers as dependancy injection mechanism
//           articleDVC.article = article
//
//           // DP Step 6. Setting up data persistance and its delegate
//           // passinge the persistance
//           articleDVC.dataPersistance = dataPersistance
//
//           // we cannot use navigation controller to push viewcontroller
//           // UNTIL WE EMBADE IT TO NAVIGATION CONTROLLER
//           navigationController?.pushViewController(articleDVC, animated: true)
//           // because we have never embadded a navigationcontroller
    
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
           // fetchCards()
            return
        }
        cards = cards.filter { $0.cardTitle.lowercased().contains(searchText.lowercased())}
    }
}
