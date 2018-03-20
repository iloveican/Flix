//
//  LineAppsTableViewProvider.swift
//  Example
//
//  Created by DianQK on 20/03/2018.
//  Copyright © 2018 DianQK. All rights reserved.
//

import UIKit
import Flix
import RxSwift
import RxCocoa

class LineAppCollectionViewCell: UICollectionViewCell {

}

struct LineApp: StringIdentifiableType, Equatable {

    var identity: String {
        return self.id.description
    }

    static func ==(lhs: LineApp, rhs: LineApp) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.icon == rhs.icon
    }

    let id: Int
    let name: String
    let icon: UIImage

}

class LineAppsCollectionViewProvider: AnimatableCollectionViewProvider {

    func configureCell(_ collectionView: UICollectionView, cell: LineAppCollectionViewCell, indexPath: IndexPath, value: LineApp) {

    }

    func genteralValues() -> Observable<[LineApp]> {
        return Observable.just([])
    }

    typealias Cell = LineAppCollectionViewCell
    typealias Value = LineApp

}

class LineAppsTableViewProvider: UniqueCustomTableViewProvider {

}
