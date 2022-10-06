//
//  RewiewsViewController.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 03.10.2022.
//

import UIKit

class ReviewsViewController: SearchCoreViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let service: ReviewsServiceTarget
    private var reviews = Reviews()
    var teacherToSearch = String()
    
    init (service: ReviewsServiceTarget) {
        self.service = service
        super.init(buttonImage1: UIImage(systemName: "arrow.up.arrow.down"), buttonImage2: nil, largeNavigation: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidCreated() {
        super.viewDidCreated()
        service.getReviews(teacher: teacherToSearch, completion: {[weak self] _reviews in
            self?.displayReviews(reviews: _reviews)
        }, errorCompletion: nil)
        configureTableView()
        // Do any additional setup after loading the view.
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

private extension ReviewsViewController {
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.register(ReviewsTableViewCell.self, forCellReuseIdentifier: ReviewsTableViewCell.identifier)
    }
    
    func displayReviews(reviews: Reviews) {
        self.reviews = reviews
        if reviews.count == 0 {
            tableView.backgroundView = NoResultsView()
        }
        tableView.reloadData()
    }
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewsTableViewCell.identifier, for: indexPath) as? ReviewsTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        cell.reviewTextLabel.text = reviews[indexPath.row].content
        cell.ratingLabel.text = String(reviews[indexPath.row].rating)
        cell.subjectLabel.text = reviews[indexPath.row].course.name
        return cell
    }
}
