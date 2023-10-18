//
//  BookAPI.swift
//  UniService
//
//  Created by Murad Al Wajed on 18/10/2023.
//

import Foundation
import Alamofire

extension NetworkService{
    func getAvailableBookList(name: String, completion: @escaping (Bool, String, [BookModel]?) -> Void) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let params: Parameters = [
            "name": ""
        ]
        AF.request(NetworkEndpointUrl.Endpoints.searchBook.url, method: .get, parameters: params, headers: headers){$0.timeoutInterval = TIMEOUT_INTERVAL}
        .responseDecodable(of: ResponseArray<BookModel>.self) { response in
            
            switch response.result{
            case .success(let success):
                if success.responseCode == 401 {
                }else{
                    completion(true, success.result, success.data)
                }
            case .failure(let failure):
                if failure.isSessionTaskError {
                    completion(false, "Request timeout, please try again." ,nil)
                }else{
                    completion(false, "Failed to parse data \(failure)" ,nil)
                }
                
            }
        }
    }
}
