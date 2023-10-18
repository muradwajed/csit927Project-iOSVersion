//
//  ResourceCell.swift
//  UniService
//
//  Created by Murad Al Wajed on 17/10/2023.
//

import UIKit

class ResourceCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let featureLabel = UILabel()
    
    
    func initUI(){
        self.backgroundColor = .clear
        featureLabel.frame = CGRect(x: screenWidth * 0.05, y: 5, width: screenWidth * 0.9, height: 25)
        featureLabel.text = ""
        featureLabel.textColor = .blue
        featureLabel.textAlignment = .left
        self.contentView.addSubview(featureLabel)
        
    }
        
}
