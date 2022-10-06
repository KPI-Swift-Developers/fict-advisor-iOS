//
//  SubjectsViewController.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 27.09.2022.
//

import UIKit
import SnapKit

class SubjectsViewController: SearchCoreViewController {
    
    init(service: SubjectsServiceTarget, paging: PagingSubjectsService) {
        self.service = service
        self.paging = paging
        super.init(
            buttonImage1: UIImage(systemName: "arrow.up.arrow.down"),
            buttonImage2: nil,
            largeNavigation: true)
        configureTableView()
        configureViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewDidCreated() {
        super.viewDidCreated()
        service.getSubjects(
            page: 0,
            sort: sortingType,
            completion: {
                [unowned self] _subjects in
                displaySubjects(_subjects)
            },
            errorCompletion: nil)
    }
    
    override func didTapNavigationButton1() {
        let alert = UIAlertController(
            title: "Тип сортування",
            message: "Выберите один",
            preferredStyle: .actionSheet
        )
        
        alert.addAction(
            UIAlertAction(
                title: "За рейтингом",
                style: .default,
                handler: byRateButtonDidTap
            )
        )
        
        alert.addAction(
            UIAlertAction(
                title: "По имени",
                style: .default,
                handler: byNameButtonDidTap
            )
        )
        present(alert, animated: true, completion: nil)
    }
    
    override func didTapCloseButton(_ searchBarViewController: UISearchController) {
        displaySubjects(storedSubjects)
    }
    
    override func didEnterTextIn(_ searchBarViewController: UISearchController) {
        guard
            let string = searchBarViewController.searchBar.text
        else {
            return
        }
        
        service.searchSubjects(string, page: 0, pageSize: 10, sort: sortingType, completion: {
            [weak self] subs in
            guard let self = self else { return }
            self.subjects = subs
            self.tableView.reloadData()
        }, errorCompletion: nil)
        
//        let filteredSubs = storedSubjects.filter {
//            $0.name
//                .lowercased()
//                .contains(
//                    string.lowercased()
//                )
//        }
//
//        if string.isEmpty {
//            subjects = storedSubjects
//            tableView.reloadData()
//            return
//        }
//
//        subjects = filteredSubs
//        tableView.reloadData()
    }

    private var subjects = Subjects()
    private var sortingType: SortingType = .byName
    private var storedSubjects = Subjects()
    
    private let paging: PagingSubjectsService
    private let service: SubjectsServiceTarget
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let loadMoreButton = StateButton(title: "load more")
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
    
    @objc func loadMoreButtonDidTap() {
        loadMoreButton.startLoading()
        paging.pagedSubjects(
            sort: sortingType,
            completion: {
                [weak self] subs in
                guard let self = self else { return }
                self.loadMoreButton.stopLoading()
                self.subjects.append(contentsOf: subs)
                self.displaySubjects(self.subjects)
            },
            errorCompletion: nil)
    }
}

private extension SubjectsViewController {
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
            SubtitleTableViewCell.self,
            forCellReuseIdentifier: "cell")
    }
    
    func displaySubjects(_ subjects: Subjects) {
        self.subjects = subjects
        self.storedSubjects = subjects
        tableView.reloadData()
    }
}

extension SubjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(
            OneSubjectViewController.module(subject: subjects[indexPath.row]),
            animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
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
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "teacher count: \(subjects[indexPath.row].teacherCount)"
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        viewForFooterInSection section: Int
    ) -> UIView? {
        let footer = UIView()
        
        footer.addSubview(loadMoreButton)
        loadMoreButton.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.right.equalToSuperview()
        }
        
        loadMoreButton.backgroundColor = .secondarySystemGroupedBackground
        loadMoreButton.setTitleColor(.systemBlue, for: .normal)
        loadMoreButton.layer.cornerRadius = 10
        loadMoreButton.addTarget(self, action: #selector(loadMoreButtonDidTap), for: .touchUpInside)
        return footer
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForFooterInSection section: Int
    ) -> CGFloat {
        return 65
    }
}
