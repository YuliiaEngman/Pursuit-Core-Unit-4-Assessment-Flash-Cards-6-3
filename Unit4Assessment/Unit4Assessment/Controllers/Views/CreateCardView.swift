//
//  CreateCardView.swift
//  Unit4Assessment
//
//  Created by Yuliia Engman on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateCardView: UIView {

    public lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter your question"
        textfield.backgroundColor = .systemGray5
        return textfield
    }()
    
    public lazy var textView1: UITextView = {
        let textview1 = UITextView()
        textview1.backgroundColor = .systemGray5
        return textview1
    }()
    
    public lazy var textView2: UITextView = {
        let textview2 = UITextView()
        textview2.backgroundColor = .systemGray5
        return textview2
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
        setupTextFieldConstraints()
        setupTextView1Constraints()
        setupTextView2Constraints()
    }
    
    private func setupTextFieldConstraints() {
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTextView1Constraints() {
            addSubview(textView1)
            textView1.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textView1.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
                textView1.leadingAnchor.constraint(equalTo: leadingAnchor),
                textView1.trailingAnchor.constraint(equalTo: trailingAnchor),
               textView1.heightAnchor.constraint(equalToConstant: 150)
            ])
        }
    
    private func setupTextView2Constraints() {
            addSubview(textView2)
            textView2.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textView2.topAnchor.constraint(equalTo: textView1.bottomAnchor, constant: 20),
                textView2.leadingAnchor.constraint(equalTo: leadingAnchor),
                textView2.trailingAnchor.constraint(equalTo: trailingAnchor),
               textView2.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    
    

}
