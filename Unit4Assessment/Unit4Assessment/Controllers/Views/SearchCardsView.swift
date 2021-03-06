//
//  SearchCardsView.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchCardsView: UIView {

    public lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.autocapitalizationType = .none
        sb.placeholder = "search for cards"
        return sb
    }()
    
    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGreen
        return cv
    }()

        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super .init(coder: coder)
            commonInit()
        }
        
        private func commonInit(){
            setupSearchBarConstraints()
            setupLayoutConstraints()
        }
        
    private func setupSearchBarConstraints() {
         addSubview(searchBar)
         searchBar.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
             searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
             searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)
         ])
     }
    
    private func setupLayoutConstraints() {
         addSubview(collectionView)
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
             collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
             collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
             collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
             collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
         ])
     }

}
