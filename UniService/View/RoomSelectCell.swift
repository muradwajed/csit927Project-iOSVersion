//
//  RoomSelectCell.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import UIKit

class RoomSelectCell: UITableViewCell {
    
    
    let bookButton = UIButton()
    var selectRoomCellDelegate: SelectRoomCellDelegate?
    
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
        featureLabel.frame = CGRect(x: screenWidth * 0.05, y: 5, width: screenWidth * 0.5, height: 25)
        featureLabel.text = "Featured"
        featureLabel.textColor = .blue
        featureLabel.textAlignment = .left
        self.contentView.addSubview(featureLabel)
        
        bookButton.frame = CGRect(x: screenWidth * 0.75, y: 5, width: screenWidth * 0.2, height: self.frame.height - 10)
        bookButton.backgroundColor = UIColor.init(red: 52/255, green: 90/255, blue: 150/255, alpha: 1)
        bookButton.layer.cornerRadius = 4
        bookButton.layer.masksToBounds = true
        bookButton.layer.borderWidth = 2
        bookButton.layer.borderColor = UIColor.lightGray.cgColor
        bookButton.setTitle("Book", for: .normal)
        bookButton.addTarget(self, action: #selector(bookSelected), for: .touchUpInside)
        bookButton.setTitleColor(.white, for: .normal)
        
        self.contentView.addSubview(bookButton)
        
    }
    
    @objc func bookSelected(_ sender: UIButton){
        selectRoomCellDelegate?.selectedRoom(No: Int(sender.tag) - 500)
    }
    
}

protocol SelectRoomCellDelegate{
    func selectedRoom(No: Int)
}
