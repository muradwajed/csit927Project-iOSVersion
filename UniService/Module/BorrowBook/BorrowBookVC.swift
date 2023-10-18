//
//  BorrowBookVC.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import UIKit

class BorrowBookVC: UIViewController {

    let searchBar = UITextField()
    let searchButton = UIButton()
    
    var bookList: [BookModel] = [BookModel]()
    
    var bookTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBackground
        initUI()
    }
    
    func initUI(){
        searchBar.frame = CGRect(x: screenWidth * 0.05, y: 90, width: screenWidth * 0.7, height: 40)
        self.view.addSubview(searchBar)
        searchBar.backgroundColor = .clear
        searchBar.layer.cornerRadius = 5
        searchBar.layer.masksToBounds = true
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.layer.borderWidth = 2
        searchBar.placeholder = " Search Books"
        
        
        searchButton.frame = CGRect(x: searchBar.frame.maxX + 15, y: 90, width: screenWidth * 0.2, height: 40)
        self.view.addSubview(searchButton)
        searchButton.layer.cornerRadius = 5
        searchButton.layer.masksToBounds = true
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor.white.cgColor
        searchButton.backgroundColor = UIColor.init(red: 52/255, green: 90/255, blue: 150/255, alpha: 1)
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        bookTableView.frame = CGRect(x: 0, y: searchBar.frame.maxY + 10, width: screenWidth, height: screenHeight - searchBar.frame.maxY)
        bookTableView.backgroundColor = .blue
        bookTableView.keyboardDismissMode = .onDrag
        bookTableView.backgroundColor = .clear
        bookTableView.showsVerticalScrollIndicator = false
        bookTableView.allowsSelection = true
        bookTableView.delegate = self
        bookTableView.dataSource = self
        bookTableView.separatorColor = .clear
        bookTableView.register(BorrowBookCell.self, forCellReuseIdentifier: "BorrowBookCell")
        self.view.addSubview(bookTableView)
    }
    
    @objc func searchAction(_ sender: UIButton){
        guard let text = searchBar.text else {return}
        
        NetworkService.shared.getAvailableBookList(name: text,completion: { success, message, response in
            
            if success {
                if let res = response{
                    self.bookList = res
                    self.bookTableView.reloadData()
                }
                
            }else{
                
            }
            
        })
        
        searchBar.endEditing(true)
    }
    
    func showAlert(bookNo: Int, issueDate: String) {
            let alertController = UIAlertController(
                title: "Congratulations!",
                message: "Book Name: \(bookList[bookNo].bookName)\nIssue Date: \(issueDate)\n Please collect your physical book from library",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: {_ in
                    self.navigationController?.popToRootViewController(animated: true)
                }
            )
            
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
    }
}

extension BorrowBookVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BorrowBookCell", for: indexPath) as! BorrowBookCell
        cell.borrowBookCellDelegate = self
        cell.bookNameLabel.text = bookList[indexPath.row].bookName
        cell.availableLabel.text = "Available copy: \(bookList[indexPath.row].availableCopyNumber)"
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 2
        cell.bookButton.tag = 600 + indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
}

extension BorrowBookVC: BorrowBookCellDelegate{
    func selectedBook(No: Int) {
        
        let issueDate = Date.getCurrentDate()
        
        showAlert(bookNo: No, issueDate: issueDate)
    }
    
    
}

extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        return dateFormatter.string(from: Date())

    }
}
