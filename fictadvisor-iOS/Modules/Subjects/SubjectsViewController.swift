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
        configureViewController()
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
            errorCompletion: nil)
        
        configureSearchVC()
        configureButtons()
    }

    private var isAppeared = false
    private var subjects = Subjects()
    
    private let service: SubjectsServiceTarget
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let searchVC = UISearchController()
}

private extension SubjectsViewController {
    func byRateButtonDidTap(_ action: UIAlertAction) {
        
    }
    
    func byNameButtonDidTap(_ action: UIAlertAction) {
        
    }
    
    @objc func didTapSortButton(sender: AnyObject) {
        let alert = UIAlertController(
            title: "Тип сортування",
            message: "Выберите один",
            preferredStyle: .actionSheet
        )
        
        alert.addAction(
            UIAlertAction(title: "За рейтингом", style: .default, handler: byRateButtonDidTap))
        alert.addAction(
            UIAlertAction(title: "По имени", style: .default, handler: byNameButtonDidTap))
        present(alert, animated: true, completion: nil)
    }

    func configureViewController() {
        title = "Subjects"
        tabBarItem.image = UIImage(systemName: "book.closed.fill")!
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell")
    }
    
    func configureButtons() {
        let sortImage = UIImage(systemName: "arrow.up.arrow.down")!
        let sortButton = UIBarButtonItem(
            image: sortImage,
            style: .plain,
            target: self,
            action: #selector(didTapSortButton))
        navigationItem.rightBarButtonItems = [sortButton]
    }
    
    func configureSearchVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchVC
        searchVC.hidesNavigationBarDuringPresentation = false
    }
}

private extension SubjectsViewController {
    func displaySubjects(_ subjects: Subjects) {
        self.subjects = subjects
        tableView.reloadData()
    }
}

extension SubjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return subjects.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath)
        cell.textLabel?.text = subjects[indexPath.row].name
        return cell
    }
}
