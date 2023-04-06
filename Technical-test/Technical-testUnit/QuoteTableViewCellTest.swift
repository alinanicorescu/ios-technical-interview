//
//  DataManagerTest.swift
//  Technical-test
//
//  Created by Alina Nicorescu on 06.04.2023.
//

import Foundation
import XCTest

class QuoteTableViewCellTest: XCTestCase {

    var sut: QuoteTableViewCell?
    var quote: Quote?
    
    override func setUp() {
        super.setUp()
        sut = QuoteTableViewCell(style: .default, reuseIdentifier: "reuseId")
        quote = Quote(symbol: "SMI", name: "Test Quote", currency: "CHF", readableLastChangePercent: "1.06 %", last: "11,233.61", variationColor: "green", myMarket: nil, favorite: false)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testUIValues() {
        guard let quote = quote else { return }
        guard let sut = sut else { return }
        
        sut.configure(quote: quote)
           
        XCTAssertEqual(sut.nameLabel.text, quote.name, "Name label not OK")
        XCTAssertEqual(sut.currencyLabel.text, quote.currency, "Currency label not OK")
        XCTAssertEqual(sut.lastLabel.text, quote.last, "Last label not OK")
        XCTAssertEqual(sut.readableLastChangePercentLabel.text, quote.readableLastChangePercent, "ReadableLastChangePercent label not OK")
        if #available(iOS 11.0, *) {
            if let variationColor = quote.variationColor, let color = UIColor(named: variationColor) {
                XCTAssertEqual(sut.readableLastChangePercentLabel.textColor, color, "ReadableLastChangePercent label not OK")
            }
        }
        XCTAssertEqual(sut.favoriteButton.image(for: .normal),  #imageLiteral(resourceName: "no-favorite") , "Fav image  not OK")
    }
    
    func testFavoriteChange() {
        guard let quote = quote else { return }
        guard let sut = sut else { return }
               
    
        sut.configure(quote: quote)
        XCTAssertEqual(sut.favoriteButton.image(for: .normal),  #imageLiteral(resourceName: "no-favorite") , "Fav image  not OK")
        sut.toggleFavorite()
        XCTAssertEqual(sut.favoriteButton.image(for: .normal),  #imageLiteral(resourceName: "favorite") , "Fav image  not OK")
        sut.toggleFavorite()
        XCTAssertEqual(sut.favoriteButton.image(for: .normal),  #imageLiteral(resourceName: "no-favorite") , "Fav image  not OK")
    }

}
