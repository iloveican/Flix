//
//  BasicListViewController.swift
//  Example
//
//  Created by DianQK on 30/10/2017.
//  Copyright © 2017 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Flix

class BasicHeaderProvider: UniqueCustomCollectionViewSectionProvider {

    let titleButton = UIButton()

    init() {
        super.init(collectionElementKindSection: UICollectionElementKindSection.header)
        self.sectionSize = { collectionView in
            return CGSize(width: collectionView.bounds.width, height: 50)
        }
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(titleButton)
        titleButton.translatesAutoresizingMaskIntoConstraints = false
        titleButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        titleButton.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        titleButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        titleButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        titleButton.setTitleColor(UIColor.darkText, for: .normal)
        titleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        titleButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        titleButton.contentHorizontalAlignment = .left
    }

}

struct BasicExample: StringIdentifiableType, Equatable {

    static func ==(lhs: BasicExample, rhs: BasicExample) -> Bool {
        return true
    }

    let name: String
    let viewController: UIViewController.Type

    var identity: String {
        return name
    }

    static func create(_ viewControllerType: UIViewController.Type) -> BasicExample {
        return BasicExample(name: String("\(viewControllerType)".dropLast(21)), viewController: viewControllerType)
    }

}

class BasicExampleCollectionViewCell: UICollectionViewCell {

    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.backgroundColor = UIColor.white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class BasicListProvider: AnimatableCollectionViewProvider {

    typealias Cell = BasicExampleCollectionViewCell
    typealias Value = BasicExample

    let isHidden = Variable(false)

    let list = Variable<[BasicExample]>([])

    weak var viewController: UIViewController?

    init(list: [BasicExample], viewController: UIViewController) {
        self.list.value = list
        self.viewController = viewController
    }

    func configureCell(_ collectionView: UICollectionView, cell: BasicExampleCollectionViewCell, indexPath: IndexPath, value: BasicExample) {
        cell.titleLabel.text = value.name
    }

    func genteralValues() -> Observable<[BasicExample]> {
        return Observable
            .combineLatest(self.isHidden.asObservable(), self.list.asObservable()) { (isHidden, list) -> [BasicExample] in
            return isHidden ? [] : list
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath, value: BasicExample) -> CGSize? {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }

    func tap(_ collectionView: UICollectionView, indexPath: IndexPath, value: BasicExample) {
        viewController?.show(value.viewController.init(), sender: nil)
    }

}

class BasicListViewController: CollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Basic Example"

        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionHeadersPinToVisibleBounds = true

        let tableViewExampleListProvider = BasicListProvider(list: [
            BasicExample.create(TableViewMultiNodeProviderExampleViewController.self),
            BasicExample.create(AnimatableTableViewMultiNodeProviderExampleViewController.self),
            BasicExample.create(TableViewProviderExampleViewController.self),
            BasicExample.create(AnimatableTableViewProviderExampleViewController.self),
            BasicExample.create(UniqueAnimatableTableViewProviderExampleViewController.self),
            BasicExample.create(TableViewSectionProviderExampleViewController.self),
            BasicExample.create(AnimatableTableViewSectionProviderExampleViewController.self),
            BasicExample.create(UniqueCustomTableViewProviderExampleViewController.self),
            BasicExample.create(UniqueCustomTableViewSectionProviderExampleViewController.self)
            ], viewController: self)

        let tableViewExampleHeaderProvider = BasicHeaderProvider()
        tableViewExampleHeaderProvider.titleButton.setTitle("TableView Provider Example", for: .normal)
        tableViewExampleHeaderProvider.titleButton.rx.tap.asObservable()
            .withLatestFrom(tableViewExampleListProvider.isHidden.asObservable())
            .map { !$0 }
            .bind(to: tableViewExampleListProvider.isHidden)
            .disposed(by: disposeBag)

        let tableViewSectionProvider = AnimatableCollectionViewSectionProvider(
            providers: [tableViewExampleListProvider],
            headerProvider: tableViewExampleHeaderProvider
        )

        let collectionViewExampleListProvider = BasicListProvider(list: [
            BasicExample.create(CollectionViewMultiNodeProviderExampleViewController.self),
            BasicExample.create(AnimatableCollectionViewMultiNodeProviderExampleViewController.self),
            BasicExample.create(CollectionViewProviderExampleViewController.self),
            BasicExample.create(AnimatableCollectionViewProviderExampleViewController.self),
            BasicExample.create(UniqueAnimatableCollectionViewProviderExampleViewController.self),
            BasicExample.create(CollectionViewSectionProviderExampleViewController.self),
            BasicExample.create(AnimatableCollectionSectionProviderExampleViewController.self),
            BasicExample.create(UniqueCustomCollectionViewProviderExampleViewController.self),
            BasicExample.create(UniqueCustomCollectionViewSectionProviderExampleViewController.self)
            ], viewController: self)

        let collectionViewExampleHeaderProvider = BasicHeaderProvider()
        collectionViewExampleHeaderProvider.titleButton.setTitle("CollectionView Provider Example", for: .normal)
        collectionViewExampleHeaderProvider.titleButton.rx.tap.asObservable()
            .withLatestFrom(collectionViewExampleListProvider.isHidden.asObservable())
            .map { !$0 }
            .bind(to: collectionViewExampleListProvider.isHidden)
            .disposed(by: disposeBag)

        let collectionViewSectionProvider = AnimatableCollectionViewSectionProvider(
            providers: [collectionViewExampleListProvider],
            headerProvider: collectionViewExampleHeaderProvider
        )

        self.collectionView.flix.animatable.build([
            tableViewSectionProvider, collectionViewSectionProvider
            ])

    }

}
