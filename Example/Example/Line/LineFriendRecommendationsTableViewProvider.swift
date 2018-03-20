//
//  LineFriendRecommendationsTableViewProvider.swift
//  Example
//
//  Created by DianQK on 20/03/2018.
//  Copyright © 2018 DianQK. All rights reserved.
//

import UIKit
import Flix
import RxSwift
import RxCocoa

class RecommendationFriendTableViewCell: UITableViewCell {

}

struct RecommendationFriend: StringIdentifiableType, Equatable {

    var identity: String {
        return self.id.description
    }

    static func ==(lhs: RecommendationFriend, rhs: RecommendationFriend) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.avatar == rhs.avatar
    }

    let id: Int
    let name: String
    let avatar: UIImage

}

class LineFriendRecommendationsTableViewProvider: AnimatableTableViewProvider {

    func configureCell(_ tableView: UITableView, cell: RecommendationFriendTableViewCell, indexPath: IndexPath, value: RecommendationFriend) {

    }

    func genteralValues() -> Observable<[RecommendationFriend]> {
        return Observable.just([])
    }

    typealias Cell = RecommendationFriendTableViewCell
    typealias Value = RecommendationFriend

}
