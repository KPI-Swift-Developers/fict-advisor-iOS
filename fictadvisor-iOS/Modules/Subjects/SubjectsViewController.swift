//
//  SubjectsViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 27.09.2022.
//

import UIKit
import SnapKit

class SubjectsViewController: UIViewController {
    
    init(service: SubjectsServiceTarget) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isAppeared { return }
        isAppeared = false
        
        service.getSubjects(
            page: 0,
            completion: {
                [unowned self] _subjects in
                displaySubjects(_subjects)
            },
            errorCompletion: nil
        )
    }
    
    private var isAppeared = false
    private var subjects = Subjects()
    
    private let service: SubjectsServiceTarget
    private let tableView = UITableView()
}

private extension SubjectsViewController {
    func configureViewController() {
        view.backgroundColor = .lightGray
        title = "Teachers"
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

private extension SubjectsViewController {
    func displaySubjects(_ subjects: Subjects) {
        self.subjects = subjects
        tableView.reloadData()
    }
}

extension SubjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath).self
        cell.textLabel?.text = subjects[indexPath.row].name
        return cell
    }
}
