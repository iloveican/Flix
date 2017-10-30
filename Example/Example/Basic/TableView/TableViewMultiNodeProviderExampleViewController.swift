//
//  TableViewMultiNodeProviderExampleViewController.swift
//  Example
//
//  Created by DianQK on 30/10/2017.
//  Copyright © 2017 DianQK. All rights reserved.
//

import UIKit
import RxSwift
import Flix

class TitleExampleProviderCell: UITableViewCell {

    let titleLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class TableViewMultiNodeExampleProvider: TableViewMultiNodeProvider {

    func configureCell(_ tableView: UITableView, indexPath: IndexPath, value: Int) -> UITableViewCell {
        let cell = tableView
            .dequeueReusableCell(
                withIdentifier: self._flix_identity,
                for: indexPath) as! TitleExampleProviderCell
        cell.titleLabel.text = "Flix \(value)"
        return cell
    }

    func genteralValues() -> Observable<[Int]> {
        return Observable.just(Array(1...10))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath, value: Int) -> CGFloat? {
        return CGFloat(value * 40)
    }

    func register(_ tableView: UITableView) {
        tableView.register(
            TitleExampleProviderCell.self,
            forCellReuseIdentifier: self._flix_identity
        )
    }

    typealias Value = Int

}

class TableViewMultiNodeProviderExampleViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TableViewMultiNodeProvider"
        self.tableView.flix.build([TableViewMultiNodeExampleProvider()])
    }

}
