//
//  SubjectsViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 27.09.2022.
//

import UIKit
import SnapKit

class SubjectsViewController: UIViewController {
    
    init(service: SubjectsServiceTarget, paging: PagingSubjectsService) {
        self.service = service
        self.paging = paging 
        super.init(nibName: nil, bundle: nil)
        configureTableView()
        configureViewController()
        
        searchVC.searchResultsUpdater = self
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
            sort: sortingType,
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
    private var sortingType: SortingType = .byName
    
    private var storedSubjects = Subjects()
    
    private let paging: PagingSubjectsService
    private let service: SubjectsServiceTarget
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let searchVC = UISearchController()
}

private extension SubjectsViewController {
    func byRateButtonDidTap(_ action: UIAlertAction) {
        sortingType = .byRate
        
        service.getSubjects(
            page: 0,
            sort: sortingType,
            completion: {
                [weak self] _sub in
                self?.displaySubjects(_sub)
            }, errorCompletion: nil)
        
        paging.clearPage()
    }
    
    func byNameButtonDidTap(_ action: UIAlertAction) {
        sortingType = .byName
        
        service.getSubjects(
            page: paging.page,
            sort: sortingType,
            completion: {
                [weak self] _sub in
                self?.displaySubjects(_sub)
            }, errorCompletion: nil)
        
        paging.clearPage()
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
        self.storedSubjects = subjects
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
    
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        let footer = UIView()
        let button = UIButton()
        
        footer.addSubview(button)
        button.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.right.equalToSuperview()
        }
        
        button.backgroundColor = .white
        button.setTitle("Load more", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(showMoreButton), for: .touchUpInside)
        return footer
    }
    
    @objc func showMoreButton() {
        paging.pagedSubjects(
            sort: sortingType,
            completion: {
                [weak self] subs in
                guard let self = self else { return }
                self.subjects.append(contentsOf: subs)
                self.displaySubjects(self.subjects)
            },
            errorCompletion: nil)
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        return 65
    }
}

extension SubjectsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let string = searchController.searchBar.text
        else {
            return
        }
        
        let filteredSubs = storedSubjects.filter {
            $0.name
                .lowercased()
                .contains(
                    string.lowercased()
                )
        }
        
        if string.isEmpty {
            subjects = storedSubjects
            tableView.reloadData()
            return
        }
        
        subjects = filteredSubs
        tableView.reloadData()
    }
}
