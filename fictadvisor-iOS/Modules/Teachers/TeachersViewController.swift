//
//  TeachersViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 27.09.2022.
//

import UIKit


class TeachersViewController: UIViewController {
    private let service: TeachersServiceTarget
    private var teachers = Teachers()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    init (service: TeachersServiceTarget) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
        configureTableView()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        service.getTeachers(page: 0, completion: {[weak self] _teachers in
            self?.displayTeachers(_teachers)
            print(_teachers)
        }, errorCompletition: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TeachersViewController {
    func displayTeachers(_ teachers: Teachers) {
        self.teachers = teachers
        tableView.reloadData()
    }
}

private extension TeachersViewController {
    func configureViewController() {
        title = "Subjects"
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

extension TeachersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teachers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = teachers[indexPath.row].firstName + " " + teachers[indexPath.row].lastName
        return cell
    }
}

