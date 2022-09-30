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
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private var searchController = UISearchController()
    private var sortingType: SortingType = .byName
    private var isAppeared = false
    
    private var storedTeachers = Teachers()
    private var page = 0
    
    init(service: TeachersServiceTarget) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
        configureTableView()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isAppeared { return }
        isAppeared = true
        
        service.getTeachers(page: 0, sort: sortingType, completion: { [weak self] _teachers in
            self?.displayTeachers(_teachers)
        }, errorCompletition: nil)
        setupSearchController()
        configureButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TeachersViewController {
    func configureButtons() {
        let sortImage = UIImage(systemName: "arrow.up.arrow.down")!
        let sortButton = UIBarButtonItem(
            image: sortImage,
            style: .plain,
            target: self,
            action: #selector(didTapSortButton))
        navigationItem.rightBarButtonItems = [sortButton]
    }
    
    @objc func didTapSortButton() {
        let alert = UIAlertController(
            title: "Тип сортування",
            message: "Виберіть один",
            preferredStyle: .actionSheet
        )
        
        alert.addAction(UIAlertAction(title: "За ім'ям",
                                      style: .default, handler: byNameButtonDidTap))
        alert.addAction(UIAlertAction(title: "За рейтингом",
                                      style: .default, handler: byRatingButtonDidTap))
        alert.addAction(UIAlertAction(title: "Відміна",
                                      style: .cancel))
        
        present(alert, animated: true)
    }
    
    func byNameButtonDidTap(_ action: UIAlertAction) {
        sortingType = .byName
        
        service.getTeachers(page: 0, sort: sortingType, completion: {[weak self] _teachers in
            self?.displayTeachers(_teachers)
        }, errorCompletition: nil)
    }
    
    func byRatingButtonDidTap(_ action: UIAlertAction) {
        sortingType = .byRate
        
        service.getTeachers(page: page, sort: sortingType, completion: {[weak self] _teachers in
            self?.displayTeachers(_teachers)
        }, errorCompletition: nil)
    }
    
    @objc func loadMoreButtonDidTap() {
        page += 1
        print(page)
        service.getTeachers(page: page, sort: sortingType, completion: {[weak self] _teachers in
            self?.teachers.append(contentsOf: _teachers)
            self?.storedTeachers.append(contentsOf: _teachers)
            self?.tableView.reloadData()
        }, errorCompletition: nil)
    }
}

private extension TeachersViewController {
    func setupSearchController() {
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = true
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}


private extension TeachersViewController {
    func displayTeachers(_ teachers: Teachers) {
        self.teachers = teachers
        self.storedTeachers = teachers
        tableView.reloadData()
    }
}

private extension TeachersViewController {
    func configureViewController() {
        title = "Subjects"
        searchController.searchResultsUpdater = self
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.register(
            TeachersTableViewCell.self,
            forCellReuseIdentifier: TeachersTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TeachersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return teachers.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TeachersTableViewCell.identifier,
            for: indexPath) as! TeachersTableViewCell
        let teacher = teachers[indexPath.row]
        let nameString = teacher.firstName + " " + teacher.lastName
        cell.nameLabel.text = nameString
        cell.ratingLabel.text = "Рейтинг: " + String(teacher.rating)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        let button = UIButton()
        
        footer.addSubview(button)
        button.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.right.equalToSuperview()
        }
        
        button.backgroundColor = .white
        button.setTitle("Завантажити більше", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loadMoreButtonDidTap), for: .touchUpInside)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 65
    }
    
}

extension TeachersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        let filteredTeachers = storedTeachers.filter {
            $0.firstName
                .lowercased()
                .contains(
                    text.lowercased()
                )
        }
        if !searchController.isActive {
            teachers = storedTeachers
            tableView.reloadData()
        }
        teachers = filteredTeachers
        tableView.reloadData()
    }
}

