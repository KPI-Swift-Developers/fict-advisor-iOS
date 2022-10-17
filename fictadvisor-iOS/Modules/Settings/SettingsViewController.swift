//
//  SettingsViewController.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 17.10.2022.
//

import UIKit

enum Sections {
    case main
}

struct SettingsModel: Hashable {
    let id = UUID()
    let name: String
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class SettingsViewController: UIViewController {
    
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var snapshot = NSDiffableDataSourceSnapshot<Sections, SettingsModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private var datasource = UITableViewDiffableDataSource<Sections, SettingsModel>(tableView: tableView) { (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
        <#code#>
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
