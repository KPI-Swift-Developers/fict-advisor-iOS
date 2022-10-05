//
//  TeacherContactsViewController.swift
//  fictadvisor-iOS
//
//  Created by Саша Василенко on 05.10.2022.
//

import UIKit

class TeacherContactsViewController: UIViewController {
    private var teacherContacts = TeacherContacts()
    private var collectionView: UICollectionView! = nil
    let setvice: TeacherContactServiceTarget
    
    
    init(service: TeacherContactServiceTarget) {
        self.setvice = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCollectionView()
        setvice.getContacts(for: "bazaka-yurij-anatolijovich", completion: {[weak self] (_contacts) in
            self?.displayContacts(contacts: _contacts)
        }, errorCompletion: nil)
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
    
    private func displayContacts(contacts: TeacherContacts) {
        self.teacherContacts = contacts
        collectionView.reloadData()
    }
}

extension TeacherContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teacherContacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeacherContactsCollectionViewCell.identifier, for: indexPath) as? TeacherContactsCollectionViewCell
        guard let cell = cell else { return UICollectionViewCell() }
        cell.valueLabel.text = teacherContacts[indexPath.row].value
        cell.typeLabel.text = teacherContacts[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = teacherContacts[indexPath.row].value
        UIPasteboard.general.string = text
        
//        let smallVC = UIView()
//        let label = UILabel()
//        label.text = "Скопійовано"
//
//        smallVC.addSubview(label)
//        label.snp.makeConstraints {
//            $0.edges.equalToSuperview().inset(10)
//        }
//
    }
}

