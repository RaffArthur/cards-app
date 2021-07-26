//
//  CardViewController.swift
//  FINCH Test
//
//  Created by Arthur Raff on 24.07.2021.
//

import UIKit

@available(iOS 13.0, *)
class CardViewController: UIViewController {
    
    private lazy var cardView = CardView()
    private lazy var doneButton: UIBarButtonItem = {
        let bbi = UIBarButtonItem()
        bbi.title = "Добавить"
        bbi.style = .done
        bbi.tintColor = .systemGreen
        bbi.target = self
//        bbi.action = #selector()
        
        return bbi
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupScreen()
    }
    
    private func setupScreen() {
        setupLayout()
        setupContent()
    }
    
    private func setupContent() {
        title = "Новая карточка"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = doneButton
    }

    private func setupLayout() {
        view.addSubview(cardView)
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
