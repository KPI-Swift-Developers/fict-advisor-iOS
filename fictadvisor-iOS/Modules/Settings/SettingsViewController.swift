//
//  SettingsViewController.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 17.10.2022.
//

import UIKit

enum Sections {
    case main, logout
}

struct SettingsModel: Hashable {
    let id = UUID()
    let name: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class SettingsViewController: UIViewController {
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    private var snapshot = NSDiffableDataSourceSnapshot<Sections, SettingsModel>()
    private lazy var dataSource = UITableViewDiffableDataSource<Sections, SettingsModel>(
        tableView: tableView,
        cellProvider: {
            (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
            ) as UITableViewCell
            cell.textLabel?.text = item.name
            return cell
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        displaySettings()
        configureTableView()
        // Do any additional setup after loading the view.
    }
    
    
}

private extension SettingsViewController {
    func configureTableView() {
        tableView.tableHeaderView = SettingsViewControllerTableViewHeader(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width))
    }
    func displaySettings() {
        let settings = [SettingsModel(name: "Супергерої"), SettingsModel(name: "Допомога")]
        snapshot.appendSections([.main])
        snapshot.appendItems(settings, toSection: .main)
        dataSource.apply(snapshot)
    }
}
