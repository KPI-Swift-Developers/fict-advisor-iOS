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
    
    init (service: ReviewsServiceTarget) {
        self.service = service
        super.init(buttonImage1: UIImage(systemName: "arrow.up.arrow.down"), buttonImage2: nil, largeNavigation: true)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidCreated() {
        super.viewDidCreated()
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ReviewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Sas"
        return cell
    }
}
