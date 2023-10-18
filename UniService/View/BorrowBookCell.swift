//
//  BorrowBookCell.swift
//  UniService
//
//  Created by Murad Al Wajed on 18/10/2023.
//

import UIKit

class BorrowBookCell: UITableViewCell {
    
    let bookNameLabel = UILabel()
    let bookButton = UIButton()
    let availableLabel = UILabel()
    
    var borrowBookCellDelegate: BorrowBookCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func initUI(){
        self.backgroundColor = .clear
        bookNameLabel.frame = CGRect(x: screenWidth * 0.05, y: 5, width: screenWidth * 0.7, height: 25)
        bookNameLabel.text = "Book A"
        bookNameLabel.textColor = .blue
        bookNameLabel.textAlignment = .left
        self.contentView.addSubview(bookNameLabel)
        
        availableLabel.frame = CGRect(x: screenWidth * 0.05, y: 28, width: screenWidth * 0.7, height: 20)
        availableLabel.text = "Availble copy: 0"
        availableLabel.textColor = .blue
        availableLabel.textAlignment = .left
        availableLabel.font = UIFont.systemFont(ofSize: 17)
        self.contentView.addSubview(availableLabel)
        
        bookButton.frame = CGRect(x: screenWidth * 0.75, y: 5, width: screenWidth * 0.2, height: self.frame.height - 10)
        bookButton.backgroundColor = UIColor.init(red: 52/255, green: 90/255, blue: 150/255, alpha: 1)
        bookButton.layer.cornerRadius = 4
        bookButton.layer.masksToBounds = true
        bookButton.layer.borderWidth = 2
        bookButton.layer.borderColor = UIColor.lightGray.cgColor
        bookButton.setTitle("Borrow", for: .normal)
        bookButton.addTarget(self, action: #selector(bookSelected), for: .touchUpInside)
        bookButton.setTitleColor(.white, for: .normal)
        
        self.contentView.addSubview(bookButton)
        
    }
    
    @objc func bookSelected(_ sender: UIButton){
        borrowBookCellDelegate?.selectedBook(No: Int(sender.tag) - 600)
    }
    
}

protocol BorrowBookCellDelegate{
    func selectedBook(No: Int)
}

