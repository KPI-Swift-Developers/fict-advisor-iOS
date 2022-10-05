//
//  OneSubjectViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 04.10.2022.
//

import UIKit

class OneSubjectViewController: UIViewController {
        
    init(subject: Subject) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.left.right.bottom.equalToSuperview()
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        nameLabel.text = subject.name
        nameLabel.numberOfLines = 0
        nameLabel.font = .monospacedSystemFont(ofSize: 30, weight: .heavy)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private let nameLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
}

extension OneSubjectViewController {
    static func module(subject: Subject) -> OneSubjectViewController {
        return OneSubjectViewController(subject: subject)
    }
}

extension OneSubjectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 10
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}
