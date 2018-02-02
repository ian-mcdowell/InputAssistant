//
//  ViewController.swift
//  InputAssistant Sample
//
//  Created by Ian McDowell on 1/28/18.
//  Copyright © 2018 Ian McDowell. All rights reserved.
//

import UIKit
import InputAssistant

class ViewController: UIViewController {
    
    let textView: UITextView
    let inputAssistantView: InputAssistantView
    let allSuggestions = ["Suggestion", "Test", "Hello", "World", "More", "Suggestions"]
    
    init() {
        textView = UITextView()
        inputAssistantView = InputAssistantView()
        super.init(nibName: nil, bundle: nil)

        inputAssistantView.delegate = self
        inputAssistantView.dataSource = self
        inputAssistantView.leadingActions = []
        inputAssistantView.trailingActions = [
            InputAssistantAction(image: #imageLiteral(resourceName: "Down"), target: self, action: #selector(downTapped))
        ]
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupTableViewBackground
        
        inputAssistantView.attach(to: textView)
        
        view.addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            textView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            textView.bottomAnchor.constraint(lessThanOrEqualTo: view.layoutMarginsGuide.bottomAnchor),
            textView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    @objc private func addTapped() {
        print("Add")
    }
    
    @objc private func downTapped() {
        textView.resignFirstResponder()
    }
}

extension ViewController: InputAssistantViewDataSource {
    
    func textForEmptySuggestionsInInputAssistantView() -> String? {
        return "No suggestions"
    }
    
    func numberOfSuggestionsInInputAssistantView() -> Int {
        return allSuggestions.count
    }
    
    func inputAssistantView(_ inputAssistantView: InputAssistantView, nameForSuggestionAtIndex index: Int) -> String {
        return allSuggestions[index]
    }
}

extension ViewController: InputAssistantViewDelegate {
    
    func inputAssistantView(_ inputAssistantView: InputAssistantView, didSelectSuggestionAtIndex index: Int) {
        
        self.textView.insertText(allSuggestions[index])
    }
}
