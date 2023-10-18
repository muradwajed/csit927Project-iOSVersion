//
//  RoomBookVC.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import UIKit

class RoomBookVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        initUI()
    }
    
    let firstNameTF = UITextField()
    let lastNameTF = UITextField()
    let emailTF = UITextField()
    let SIDTF = UITextField()
    let dateTF = UITextField()
    
    let nextButton = UIButton()
    
    func initUI(){
        
        firstNameTF.frame = CGRect(x: screenWidth * 0.05, y: screenHeight * 0.15, width: screenWidth * 0.9, height: screenHeight * 0.05)
        firstNameTF.placeholder = " First Name"
        self.view.addSubview(firstNameTF)
        firstNameTF.addUIDesign()
        
        
        lastNameTF.frame = CGRect(x: screenWidth * 0.05, y: screenHeight * 0.25, width: screenWidth * 0.9, height: screenHeight * 0.05)
        lastNameTF.placeholder = " Last Name"
        self.view.addSubview(lastNameTF)
        lastNameTF.addUIDesign()
        
        
        emailTF.frame = CGRect(x: screenWidth * 0.05, y: screenHeight * 0.35, width: screenWidth * 0.9, height: screenHeight * 0.05)
        emailTF.placeholder = " Email Address"
        self.view.addSubview(emailTF)
        emailTF.addUIDesign()
        
        SIDTF.frame = CGRect(x: screenWidth * 0.05, y: screenHeight * 0.45, width: screenWidth * 0.9, height: screenHeight * 0.05)
        SIDTF.placeholder = " Student ID"
        self.view.addSubview(SIDTF)
        SIDTF.addUIDesign()
        
        dateTF.frame = CGRect(x: screenWidth * 0.05, y: screenHeight * 0.55, width: screenWidth * 0.9, height: screenHeight * 0.05)
        dateTF.placeholder = " Select Date (YYYY-MM-DD)"
        self.view.addSubview(dateTF)
        dateTF.addUIDesign()
        
        nextButton.frame = CGRect(x: screenWidth * 0.05, y: screenHeight * 0.65, width: screenWidth * 0.9, height: screenHeight * 0.1)
        self.view.addSubview(nextButton)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        nextButton.addUIDesign()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        view.endEditing(true)
    }
    
    @objc func nextTapped() {
        guard let ffName = firstNameTF.text else {return}
        guard let llName = lastNameTF.text else {return}
        guard let email = emailTF.text else {return}
        guard let sID = SIDTF.text else {return}
        guard let date = dateTF.text else {return}
        
        
        if ffName != "" && llName != "" && email != "" && sID != "" && date != "" {
            
            NetworkService.shared.getAvailableRoomList(completion: { success, message, response in
                
                if success {
                    print(response)
                    if let res = response{
                        let nextVC = SelectRoomVC()
                        nextVC.roomList = res
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }

                }else{
                    
                }
                
            })
            
        }
                
    }
    
    
}

extension UITextField{
    func addUIDesign(){
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray.cgColor
        
    }
}
