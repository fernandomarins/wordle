//
//  ViewController.swift
//  wordle
//
//  Created by Fernando Marins on 26/05/22.
//

import UIKit

class MainViewController: UIViewController {
    
    let answers = ["after", "later", "bloke", "there", "ultra"]
    var answer = ""
    
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    
    let keyboardViewController = KeyboardViewController()
    let boardViewController = BoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        randomAnswer()
        setTitleColor()
        addChildren()
    }
    
    private func randomAnswer() {
        answer = answers.randomElement() ?? "after"
    }
    
    private func setTitleColor() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }

    private func addChildren() {
        addChild(keyboardViewController)
        keyboardViewController.didMove(toParent: self)
        keyboardViewController.delegate = self
        keyboardViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardViewController.view)
        
        addChild(boardViewController)
        boardViewController.didMove(toParent: self)
        boardViewController.dataSource = self
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

extension MainViewController: KeyboarControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        // update guesses
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            
            if stop {
                break
            }
        }
        boardViewController.reloadData()
    }
}

extension MainViewController: BoardViewControllerDataSource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        
        let count = guesses[rowIndex].compactMap { $0 }.count
        guard count == 5 else { return nil }
        
        let indexedAnswer = Array(answer)
        
        guard let letter = guesses[indexPath.section][indexPath.row],
              indexedAnswer.contains(letter) else {
            return nil
        }
        
        
        if indexedAnswer[indexPath.row] == letter {
            return .systemGreen
        }
        
        return .systemOrange
    }
}
