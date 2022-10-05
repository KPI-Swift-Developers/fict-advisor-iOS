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
        emptyTitle: String = "No data...",
        frame: CGRect = .zero,
        style: UITableView.Style = .insetGrouped
    ) {
        super.init(frame: frame, style: style)
        
        addSubview(spinner)
        spinner.snp.makeConstraints() {
            $0.center.equalToSuperview()
        }
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints() {
            $0.centerY
                .equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        emptyLabel.text = emptyTitle
        emptyLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        spinner.startAnimating()
        
        spinner.isHidden = true
        emptyLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let spinner = UIActivityIndicatorView()
    private(set) var emptyLabel = UILabel()
}

extension StateTableView {
    func setEmptyState() {
        emptyLabel.isHidden = false
        spinner.isHidden = true
    }
    
    func popStateView() {
        emptyLabel.isHidden = true
    }
    
    func startLoading() {
        emptyLabel.isHidden = true
        spinner.isHidden = false
    }
    
    func stopLoading() {
        emptyLabel.isHidden = true
        spinner.isHidden = true
    }
}
