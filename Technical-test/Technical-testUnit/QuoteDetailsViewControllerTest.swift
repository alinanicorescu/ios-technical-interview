//
//  QuoteDetailsViewControllerTest.swift
//  Technical-test
//
//  Created by Alina Nicorescu on 06.04.2023.
//

import Foundation
import XCTest

class QuoteDetailsViewControllerTest: XCTestCase {

    var sut: QuoteDetailsViewController?
    var quote: Quote?

    override func setUp() {
        super.setUp()
        quote = Quote(symbol: "SMI", name: "Test Quote", currency: "CHF", readableLastChangePercent: "1.06 %", last: "11,233.61", variationColor: "green", myMarket: nil, favorite: false)
        sut = QuoteDetailsViewController(quote: quote!)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testUIValues() {
        guard let sut = sut else { return }
        sut.viewDidLoad()
        XCTAssertEqual(sut.nameLabel.text, quote?.name, "Name label not OK")
        XCTAssertEqual(sut.currencyLabel.text, quote?.currency, "Currency label not OK")
        XCTAssertEqual(sut.lastLabel.text, quote?.last, "Last label not OK")
        XCTAssertEqual(sut.readableLastChangePercentLabel.text, quote?.readableLastChangePercent, "ReadableLastChangePercent label not OK")
    }
    
    func testFavoriteChange() {
        guard let sut = sut else { return }
        sut.viewDidLoad()
        XCTAssertEqual(sut.favoriteButton.title(for: .normal), "Add to favorites", "Fav button title not OK")
        sut.didPressFavoriteButton(sut.favoriteButton)
        XCTAssertEqual(sut.favoriteButton.title(for: .normal), "Remove from favorites", "Fav button title not OK")
    }

}
