import XCTest

class UIFont_BTUIKTests: XCTest {

    // MARK: - bodyFont

    func testBodyFont_withCustomFont_andUseStaticSizeTrue() {
        let font = UIFont.bodyFont(forFontFamily: "Helvetica", useStaticSize: true)
        XCTAssertEqual(font, UIFont(name: "Helvetica", size: UIFont.labelFontSize))
    }

    func testBodyFont_withCustomFont_andUseStaticSizeFalse() {
        let font = UIFont.bodyFont(forFontFamily: "Helvetica", useStaticSize: false)
        XCTAssertEqual(font, UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Helvetica", size: UIFont.labelFontSize)!))
    }

    func testBodyFont_withoutCustomFont_andUseStaticSizeTrue() {

    }

    func testBodyFont_withoutCustomFont_andUseStaticSizeFalse() {

    }

    // TODO: - finish tests
}
