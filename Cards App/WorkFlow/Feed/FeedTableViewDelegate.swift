//
//  FeedTableViewDelegate.swift
//  Cards App
//
//  Created by Arthur Raff on 29.07.2021.
//

import UIKit

@available(iOS 13.0, *)
extension FeedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let trashAction = UIContextualAction(style: .destructive, title: "Удалить", handler: { (action: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            
            CardsStore.shared.cards.remove(at: indexPath.item)
            
            tableView.deleteRows(at: [indexPath], with: .fade)

            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
}
