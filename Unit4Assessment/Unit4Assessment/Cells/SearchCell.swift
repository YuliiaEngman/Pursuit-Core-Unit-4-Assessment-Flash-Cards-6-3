//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    public lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Card's Question"
        return label
    }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super .init(coder: coder)
            commonInit()
        }
        
        private func commonInit(){
            setupQuestionLabelConstraints()
        }
    
        private func setupQuestionLabelConstraints() {
            addSubview(questionLabel)
            questionLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                questionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                questionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)])
        }
    
    public func configureCell(with cards: Card) {
        questionLabel.text = cards.cardTitle
    }
}
