//
//  ViewController.swift
//  wordle
//
//  Created by Fernando Marins on 26/05/22.
//

import UIKit

class ViewController: UIViewController {
    
    let keyboardViewController = KeyboardViewController()
    let boardViewController = BoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        addChildren()
    }

    private func addChildren() {
        addChild(keyboardViewController)
        keyboardViewController.didMove(toParent: self)
        keyboardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardViewController.view)
        
        addChild(boardViewController)
        boardViewController.didMove(toParent: self)
        boardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardViewController.view)
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            boardViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardViewController.view.bottomAnchor.constraint(equalTo: keyboardViewController.view.topAnchor),
            boardViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            keyboardViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

