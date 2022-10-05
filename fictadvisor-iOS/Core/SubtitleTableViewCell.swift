//
//  SubtitleTableViewCell.swift
//  fictadvisor-iOS
//
//  Created by Jeytery on 05.10.2022.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
