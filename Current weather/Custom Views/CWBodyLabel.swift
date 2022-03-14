//
//  CWBodyLabel.swift
//  Current weather
//
//  Created by Aleksandra on 10.03.2022.
//

import UIKit

class CWBodyLabel: UILabel {

    override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    private func configure() {
        textAlignment = .left
        font = UIFont.systemFont(ofSize: 20, weight: .light)
        textColor = .systemGray
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingHead
        translatesAutoresizingMaskIntoConstraints = false
    }
}
