//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    //private var currentCard: Card!
    private var card: Card!
    
    //ANIMATION:
    private lazy var longPressGesture:
        UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
            gesture.addTarget(self, action: #selector(didLongPress(_:)))
            return gesture
    }()
    
    public lazy var addButton: UIButton = {
      let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Card's Question"
        return label
    }()
    
    public lazy var answersLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.text = "Cards Answers"
        label.alpha = 0
        return label
    }()
        
    private var isShowingAnswers = false
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
        required init?(coder: NSCoder) {
            super .init(coder: coder)
            commonInit()
        }
        
        private func commonInit(){
            setupAddButtonConstraints()
            setupQuestionLabelConstraints()
            setupAnswersLabelConstraints()
            
            addGestureRecognizer(longPressGesture)
            questionLabel.isUserInteractionEnabled = true
            answersLabel.isUserInteractionEnabled = true
        }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        print("outside gesture")
        //guard let currentCard = card else { return }
        if gesture.state == .began ||
            gesture.state == .changed {
        print("long pressed")
            return
        }
        
        isShowingAnswers.toggle()
        self.animate()
    }
    
    private func animate() {
        let duration: Double = 1.0 // seconds
        if isShowingAnswers {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.answersLabel.alpha = 1.0
                self.questionLabel.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.answersLabel.alpha = 0.0
                self.questionLabel.alpha = 1.0
            }, completion: nil)
        }
    }
    
    @objc private func addButtonPressed(_ sender: UIButton){
        print("button was pressed for card \(card.quizTitle)")
        
        //FIXME: delegate?.didSelectMoreButton(self, article: currentArticle)
    }
    
    private func setupAddButtonConstraints() {
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor)
        ])
    }
    
        private func setupQuestionLabelConstraints() {
            addSubview(questionLabel)
            questionLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                questionLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor),
                questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
        }
    
    private func setupAnswersLabelConstraints() {
        addSubview(answersLabel)
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answersLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor),
            answersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            answersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            answersLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configureCell(with cards: Card) {
        questionLabel.text = cards.quizTitle
        answersLabel.text = """
        \(cards.facts.first?.description ?? "")

        \(cards.facts.last?.description ?? "")
"""
    }
}
