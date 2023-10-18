//
//  DownloadResourceVC.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import UIKit
import PDFKit
class DownloadResourceVC: UIViewController {
    
    let searchBar = UITextField()
    let searchButton = UIButton()
    
    var resourcesList: [ResourceModel] = [ResourceModel]()
    
    var resourceTableView = UITableView()
    
    var pdfURL: URL = URL(fileURLWithPath: "")
    
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
        searchBar.placeholder = " Search Resources"
        
        
        searchButton.frame = CGRect(x: searchBar.frame.maxX + 15, y: 90, width: screenWidth * 0.2, height: 40)
        self.view.addSubview(searchButton)
        searchButton.layer.cornerRadius = 5
        searchButton.layer.masksToBounds = true
        searchButton.layer.borderWidth = 2
        searchButton.layer.borderColor = UIColor.white.cgColor
        searchButton.backgroundColor = UIColor.init(red: 52/255, green: 90/255, blue: 150/255, alpha: 1)
        searchButton.setTitle("Search", for: .normal)
        searchButton.addTarget(self, action: #selector(searchAction), for: .touchUpInside)
        
        resourceTableView.frame = CGRect(x: 0, y: searchBar.frame.maxY + 10, width: screenWidth, height: screenHeight - searchBar.frame.maxY)
        resourceTableView.backgroundColor = .blue
        resourceTableView.keyboardDismissMode = .onDrag
        resourceTableView.backgroundColor = .clear
        resourceTableView.showsVerticalScrollIndicator = false
        resourceTableView.allowsSelection = true
        resourceTableView.delegate = self
        resourceTableView.dataSource = self
        resourceTableView.separatorColor = .clear
        resourceTableView.register(ResourceCell.self, forCellReuseIdentifier: "ResourceCell")
        self.view.addSubview(resourceTableView)
    }
    
    @objc func searchAction(_ sender: UIButton){
        guard let text = searchBar.text else {return}
        NetworkService.shared.getResourceList(name: text,completion: { success, message, response in
            
            if success {
                print(response)
                if let res = response{
                    self.resourcesList = res
                    self.resourceTableView.reloadData()
                }
                
            }else{
                
            }
            
        })
        
        searchBar.endEditing(true)
    }
    
}

extension DownloadResourceVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourcesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResourceCell", for: indexPath) as! ResourceCell
        cell.featureLabel.text = resourcesList[indexPath.row].resourceName
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.borderWidth = 2
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
        guard let url = URL(string: resourcesList[indexPath.row].resourceURL) else { return }
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
    }
    
}

extension DownloadResourceVC:  URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Documentdo {
        try? FileManager.default.copyItem(at: location, to: destinationURL)
        self.pdfURL = destinationURL
        
        DispatchQueue.main.async {
            let pdfViewController = PDFVC()
            pdfViewController.pdfURL = self.pdfURL
            self.navigationController?.pushViewController(pdfViewController, animated: true)
        }
    }
}
