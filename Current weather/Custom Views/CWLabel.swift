//
//  CWLabel.swift
//  Current weather
//
//  Created by Aleksandra on 10.03.2022.
//

import UIKit

class CWTitleLabel: UILabel {

    override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
        
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, textColor: UIColor) {
            self.init(frame: .zero)
            self.textAlignment = textAlignment
            self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
            self.textColor = textColor
        }
        
    private func configure() {
      translatesAutoresizingMaskIntoConstraints = false
        }
    }


