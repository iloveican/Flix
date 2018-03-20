//
//  LineFriendsTableViewProvider.swift
//  Example
//
//  Created by DianQK on 20/03/2018.
//  Copyright © 2018 DianQK. All rights reserved.
//

import UIKit
import Flix
import RxSwift
import RxCocoa

class LineFriendTableViewCell: UITableViewCell {

}

struct LineFriend: StringIdentifiableType, Equatable {

    var identity: String {
        return self.id.description
    }

    static func ==(lhs: LineFriend, rhs: LineFriend) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.avatar == rhs.avatar && lhs.statusMessage == rhs.statusMessage
    }


    let id: Int
    let name: String
    let avatar: UIImage
    let statusMessage: String?

}

class LineFriendsTableViewProvider: AnimatableTableViewProvider, TableViewEditable {

    func _tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, node: _Node) -> [UITableViewRowAction]? {
        return [
            UITableViewRowAction(style: .default, title: "Hide", handler: { (action, indexPath) in

            }),
            UITableViewRowAction(style: .destructive, title: "Block", handler: { (action, indexPath) in

            })
        ]
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath, value: LineFriend) -> UITableViewCellEditingStyle {
        return .none
    }

    func configureCell(_ tableView: UITableView, cell: LineFriendTableViewCell, indexPath: IndexPath, value: LineFriend) {

    }

    func genteralValues() -> Observable<[LineFriend]> {
        return Observable.just([])
    }

    typealias Cell = LineFriendTableViewCell
    typealias Value = LineFriend

}
