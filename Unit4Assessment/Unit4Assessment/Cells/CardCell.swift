//
//  CardCell.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

// Custom Delegate Step 1
protocol CardCellDelegate: AnyObject {
    func didSelectMoreActionsButton(_ cardCell: CardCell, card: Card)
}

class CardCell: UICollectionViewCell {
    
    weak var delegate: CardCellDelegate?
    
private var currentCard: Card!
    
    //ANIMATION:
    private lazy var longPressGesture:
        UILongPressGestureRecognizer = {
            let gesture = UILongPressGestureRecognizer()
            gesture.addTarget(self, action: #selector(didLongPress(_:)))
            return gesture
    }()
    
    public lazy var moreActionsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreActionsButtonPressed(_:)), for: .touchUpInside)
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
        setupMoreActionsButtonConstraints()
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
    
    @objc private func moreActionsButtonPressed(_ sender: UIButton){
        print("button was pressed for card \(String(describing: currentCard.quizTitle))")
        
        //FIXME:
        delegate?.didSelectMoreActionsButton(self, card: currentCard)
    }
    
    private func setupMoreActionsButtonConstraints() {
        addSubview(moreActionsButton)
        moreActionsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreActionsButton.topAnchor.constraint(equalTo: topAnchor),
            moreActionsButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        moreActionsButton.heightAnchor.constraint(equalToConstant: 44),
            moreActionsButton.widthAnchor.constraint(equalTo: moreActionsButton.heightAnchor)
        ])
    }
    
    private func setupQuestionLabelConstraints() {
        addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: moreActionsButton.bottomAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    private func setupAnswersLabelConstraints() {
        addSubview(answersLabel)
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answersLabel.topAnchor.constraint(equalTo: moreActionsButton.bottomAnchor),
            answersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            answersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            answersLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func configureCell(for savedCard: Card) {
        currentCard = savedCard
        questionLabel.text = savedCard.quizTitle
        answersLabel.text = """
        \(savedCard.facts?.first ?? "")
        
        \(savedCard.facts?.last ?? "")
        """
    }
}
