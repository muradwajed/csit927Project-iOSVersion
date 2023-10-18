//
//  NetworkService.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import Foundation
import Alamofire

let TIMEOUT_INTERVAL: Double = 60.0
class NetworkService {
    public static let shared = NetworkService()
    
    
    //MARK:- cancelPreviousRequests
    func cancelPreviousRequests(url: URL){
        AF.session.getAllTasks { (tasks) in
            tasks.forEach {
                if ($0.originalRequest?.url == url){
                    $0.cancel()
                    print("Request Canceled: \(url)")
                }else if let urlString = $0.originalRequest?.url?.absoluteString{
                    if urlString.contains(url.absoluteString){
                        $0.cancel()
                        print("Request Canceled: \(url)")
                    }
                }
            }
        }
    }

}
