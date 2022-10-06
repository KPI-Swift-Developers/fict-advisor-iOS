//
//  StateTableView.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 05.10.2022.
//

import UIKit
import SnapKit

class StateTableView: UITableView {
    
    init(
        emptyTitle: String = "Нет данных",
        frame: CGRect = .zero,
        style: UITableView.Style = .insetGrouped
    ) {
        super.init(frame: frame, style: style)
        
        emptyLabel.text = emptyTitle
        emptyLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        emptyLabel.textColor = .secondaryLabel
        spinner.startAnimating()
        emptyLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let spinner = UIActivityIndicatorView()
    private(set) var emptyLabel = UILabel()
}

extension StateTableView {
    func setEmptyState() {
        self.backgroundView = emptyLabel
    }
    
    func popEmptyState() {
        self.backgroundView = nil
    }
    
    func startLoading() {
        self.backgroundView = spinner
    }
    
    func stopLoading() {
        self.backgroundView = nil
    }
}
