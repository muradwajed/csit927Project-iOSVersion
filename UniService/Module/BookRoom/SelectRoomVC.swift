//
//  SelectRoomVC.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import UIKit

class SelectRoomVC: UIViewController {

    let roomListTableView = UITableView()
    
    
    var roomList: [RoomModel] = [RoomModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBackground
        
        initTableview()
    }
    
    func initTableview(){
        roomListTableView.frame = CGRect(x: 0, y: screenHeight * 0.1, width: screenWidth, height: screenHeight * 0.9)
        roomListTableView.keyboardDismissMode = .onDrag
        roomListTableView.backgroundColor = .clear
        self.view.addSubview(roomListTableView)
        roomListTableView.showsVerticalScrollIndicator = false
        roomListTableView.allowsSelection = false
        roomListTableView.delegate = self
        roomListTableView.dataSource = self
        roomListTableView.separatorColor = .clear
        roomListTableView.register(RoomSelectCell.self, forCellReuseIdentifier: "RoomSelectCell")
    }

    
    func showAlert(roomNo: Int) {
            let alertController = UIAlertController(
                title: "Congratulations!",
                message: "Room \(roomNo) has been book for you.",
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

extension SelectRoomVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomSelectCell", for: indexPath) as! RoomSelectCell
        cell.featureLabel.text = "Room No: \(roomList[indexPath.row].roomNumber)"
        cell.bookButton.tag = 500 + indexPath.row
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 2
        cell.selectRoomCellDelegate = self
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenWidth * 0.12
    }
}

extension SelectRoomVC: SelectRoomCellDelegate{
    func selectedRoom(No: Int) {
        self.showAlert(roomNo: roomList[No].roomNumber)
        
        
    }
    
    
}
