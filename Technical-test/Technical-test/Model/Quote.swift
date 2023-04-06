//
//  Quote.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import Foundation

struct Quote: Decodable {
    var symbol:String?
    var name:String?
    var currency:String?
    var readableLastChangePercent:String?
    var last:String?
    var variationColor:String?
    var myMarket:Market?
    var favorite: Bool = false
    
   private enum CodingKeys: CodingKey {
        case symbol, name, currency, readableLastChangePercent,last, variationColor
    }

}
