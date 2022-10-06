//
//  TeacherSubjectsViewController.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 05.10.2022.
//

import UIKit

class TeacherSubjectsViewController: UIViewController {
    var teacherToSearch = String()
    let service: TeacherSubjectsServiceTarget
    var subjects = TeacherSubjects()
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    init(service: TeacherSubjectsServiceTarget) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTableView()
        service.getSubjects(for: teacherToSearch, completion: {[weak self] (_subjects) in
            self?.displaySubjects(subjects: _subjects)
        }, errorCompletion: nil)
    }
}

private extension TeacherSubjectsViewController {
    func configureTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func displaySubjects(subjects: TeacherSubjects) {
        self.subjects = subjects
        if subjects.count == 0 {
            tableView.backgroundView = NoResultsView()
        }
        tableView.reloadData()
    }
}

extension TeacherSubjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = subjects[indexPath.row].name
        return cell
    }
}
