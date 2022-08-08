//
//  CustomCell.swift
//  RequestLibrary_Example
//
//  Created by  Yeskendir Ayat on 08.08.2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    static let identifier: String = "test_cell_identifier"
    var label: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    
    func configure() {
        label = UILabel(frame: .zero)
        self.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
