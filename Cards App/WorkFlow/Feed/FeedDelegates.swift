//
//  FeedDelegates.swift
//  Cards App
//
//  Created by Arthur Raff on 19.08.2023.
//

import Foundation

protocol FeedViewDelegate: AnyObject {
    func showFullCardDetailsScreenBy(index: Int)
    func removeCardBy(index: Int)
}
