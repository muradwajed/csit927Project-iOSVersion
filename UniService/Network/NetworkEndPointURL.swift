//
//  NetworkEndPointURL.swift
//  UniService
//
//  Created by Murad Al Wajed on 16/10/2023.
//

import Foundation

class NetworkEndpointUrl {
    
    enum Endpoints {
        
        //MARK: - Api Urls
        
        static let BASE_URL = "https://devilarticle.com/api/LibraryService"
        
        static let API_HEADER_KEY = "Accept"
        static let API_HEADER_VALUE = "application/json"

        //MARK: - Api Endpoints
        
        case availableRoomList
        case bookThisRoom
        
        case resourceList
        
        case searchBook
        
        var stringValue: String {
            switch self {
            case .availableRoomList:
                return Endpoints.BASE_URL + "/GetAllAvailableRoom"
            case .bookThisRoom:
                return Endpoints.BASE_URL + "/BookRoom"
            case .resourceList:
                return Endpoints.BASE_URL + "/SearchOnlineResource"
            case .searchBook:
                return Endpoints.BASE_URL + "/GetAllBook"
            }
            
        }//stringValue
        var url: URL {
            return URL(string: stringValue) ?? URL(string: "https://devilarticle.com")!
        }
        
    }//Endpoints
    
}//NetworkEndpointUrl
