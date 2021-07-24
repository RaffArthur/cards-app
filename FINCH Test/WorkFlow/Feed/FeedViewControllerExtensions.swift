//
//  FeedViewControllerExtensions.swift
//  FINCH Test
//
//  Created by Arthur Raff on 22.07.2021.
//

import UIKit

@available(iOS 13.0, *)
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FeedTableViewCell.self), for: indexPath) as! FeedTableViewCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.layer.masksToBounds = true
        
        return cell
    }
}

@available(iOS 13.0, *)
extension FeedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let trashAction = UIContextualAction(style: .destructive, title: "Удалить", handler: { (action: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            print("Update action ...")
            
            success(true)
        })
        
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
}
