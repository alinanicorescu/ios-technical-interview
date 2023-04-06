//
//  DataManager.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation
import Alamofire

class DataManager {
    
    private static let path = "https://www.swissquote.ch/mobile/iphone/Quote.action?formattedList&formatNumbers=true&listType=SMI&addServices=true&updateCounter=true&&s=smi&s=$smi&lastTime=0&&api=2&framework=6.1.1&format=json&locale=en&mobile=iphone&language=en&version=80200.0&formatNumbers=true&mid=5862297638228606086&wl=sq"
    
    func fetchQuotes(completionHandler: @escaping ([Quote]?, Error?) -> Void) {
        AF.request(DataManager.path).validate(statusCode: [200]).responseDecodable(of: [Quote].self) {response in
           switch response.result {
            case .success(let quotes):
                completionHandler(quotes, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
}
