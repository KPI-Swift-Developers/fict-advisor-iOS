//
//  TeacherContactsViewController.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 05.10.2022.
//

import UIKit

class TeacherContactsViewController: UIViewController {
    private var collectionView: UICollectionView! = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCollectionView()
        
    }
}

extension TeacherContactsViewController {
    private func configureCollectionView() {
        let layuot = UICollectionViewFlowLayout()
        layuot.scrollDirection = .vertical
        layuot.itemSize = CGSize(width: (view.bounds.width/3) - 7, height: view.bounds.height/10)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TeacherContactsCollectionViewCell.self, forCellWithReuseIdentifier: TeacherContactsCollectionViewCell.identifier)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension TeacherContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeacherContactsCollectionViewCell.identifier, for: indexPath) as? TeacherContactsCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        cell.valueLabel.text = "@ssshashka"
        cell.typeLabel.text = "Telegram"
        return cell
    }
}

