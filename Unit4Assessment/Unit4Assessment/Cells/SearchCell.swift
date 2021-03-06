//
//  SearchCell.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

//Custom Delegation: Step 1 out of 6
protocol SearchCellDelegate: AnyObject {
    func didSelectAddButton(_ searchCell: SearchCell, card: Card)
}

class SearchCell: UICollectionViewCell {
    
    //Custom Delegation: Step 2 out of 6
    weak var delegate: SearchCellDelegate?
    
    private var currentCard: Card!
    
    //ANIMATION:
//    private lazy var longPressGesture:
//        UILongPressGestureRecognizer = {
//            let gesture = UILongPressGestureRecognizer()
//            gesture.addTarget(self, action: #selector(didLongPress(_:)))
//            return gesture
//    }()
    
    //create tap gesture:
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(tapPressed(_:)))
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
    
    //Custom Delegation: Step 3 out of 6
    @objc private func addButtonPressed(_ sender: UIButton){
        print("add button was pressed for card \(String(describing: currentCard.quizTitle))")
        //FIXME:
        delegate?.didSelectAddButton(self, card: currentCard)
    }
    
    private func commonInit(){
        setupAddButtonConstraints()
        setupQuestionLabelConstraints()
        setupAnswersLabelConstraints()
        
        addGestureRecognizer(tapGesture)
        questionLabel.isUserInteractionEnabled = true
        answersLabel.isUserInteractionEnabled = true
    }
    
//    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
//        print("outside gesture")
//        //guard let currentCard = card else { return }
//        if gesture.state == .began ||
//            gesture.state == .changed {
//            print("long pressed")
//            return
//        }
//
//        isShowingAnswers.toggle()
//        self.animate()
//    }
    
    @objc private func tapPressed(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .began ||
            gesture.state == .changed {
            print("tap pressed")
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
    
    public func configureCell(for card: Card) {
        currentCard = card
        questionLabel.text = card.quizTitle
        answersLabel.text = """
        \(card.facts?.first ?? "")
        
        \(card.facts?.last ?? "")
        """
    }
}
