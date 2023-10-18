//
//  ViewController.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import UIKit

let screenSize = UIScreen.main.bounds
let screenHeight = screenSize.height
let screenWidth = screenSize.width

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUI()
    }
    
    func initUI(){
        // Create and configure the "Book a Room" button
        let bookRoomButton = UIButton(type: .system)
        bookRoomButton.frame = CGRect(x: screenWidth * 0.1, y: screenHeight * 0.1, width: screenWidth * 0.8, height: screenHeight * 0.2)
        bookRoomButton.setTitle("Book a Room", for: .normal)
        bookRoomButton.addTarget(self, action: #selector(bookRoomTapped), for: .touchUpInside)
        bookRoomButton.addUIDesign()
        view.addSubview(bookRoomButton)
        
        // Create and configure the "Borrow a Book" button
        let borrowBookButton = UIButton(type: .system)
        borrowBookButton.frame = CGRect(x: screenWidth * 0.1, y: screenHeight * 0.4, width: screenWidth * 0.8, height: screenHeight * 0.2)
        borrowBookButton.setTitle("Borrow a Book", for: .normal)
        borrowBookButton.addTarget(self, action: #selector(borrowBookTapped), for: .touchUpInside)
        borrowBookButton.addUIDesign()
        view.addSubview(borrowBookButton)
        
        // Create and configure the "Search Online Resource" button
        let searchOnlineButton = UIButton(type: .system)
        searchOnlineButton.frame = CGRect(x: screenWidth * 0.1, y: screenHeight * 0.7, width: screenWidth * 0.8, height: screenHeight * 0.2)
        searchOnlineButton.setTitle("Search Online Resource", for: .normal)
        searchOnlineButton.addTarget(self, action: #selector(searchOnlineTapped), for: .touchUpInside)
        searchOnlineButton.addUIDesign()
        view.addSubview(searchOnlineButton)
        
        
        
    }
    
    @objc func bookRoomTapped() {
        // Handle the "Book a Room" button tap action here
        print("Book a Room button tapped")
        let bookRoomVC = RoomBookVC()
        self.navigationController?.pushViewController(bookRoomVC, animated: true)
    }
    
    @objc func borrowBookTapped() {
        // Handle the "Borrow a Book" button tap action here
        print("Borrow a Book button tapped")
        let borrowRoomVC = BorrowBookVC()
        self.navigationController?.pushViewController(borrowRoomVC, animated: true)
    }
    
    @objc func searchOnlineTapped() {
        // Handle the "Search Online Resource" button tap action here
        print("Search Online Resource button tapped")
        let searchOnlineResourceVC = DownloadResourceVC()
        self.navigationController?.pushViewController(searchOnlineResourceVC, animated: true)
    }
    
}


extension UIButton{
    func addUIDesign(){
        self.backgroundColor = UIColor.init(red: 52/255, green: 90/255, blue: 150/255, alpha: 1)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        
    }
}
