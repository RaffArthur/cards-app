//
//  FeedTableViewDataSource.swift
//  FINCH Test
//
//  Created by Arthur Raff on 29.07.2021.
//

import UIKit

@available(iOS 13.0, *)
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cardDetailsVC = CardDetailsViewController()
        cardDetailsVC.card = CardsStore.shared.cards[indexPath.item]
        
        guard let navigationController = navigationController else { return }
        navigationController.pushViewController(cardDetailsVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CardsStore.shared.cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedTableViewCell.self), for: indexPath) as! FeedTableViewCell
        
        cell.card = CardsStore.shared.cards[indexPath.item]
        
        return cell
    }
}
