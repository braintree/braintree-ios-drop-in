import XCTest

class UIFont_BTUIKTests: XCTestCase {

    // MARK: - bodyFont

    func testBodyFont_withCustomFont_andUseStaticSizeTrue_returnsProperFont() {
        let font = UIFont.bodyFont(forFontFamily: "Courier", useStaticSize: true)
        XCTAssertEqual(font, UIFont(name: "Courier", size: UIFont.labelFontSize))
    }

    func testBodyFont_withCustomFont_andUseStaticSizeFalse_returnsProperFont() {
        let font = UIFont.bodyFont(forFontFamily: "Courier", useStaticSize: false)
        XCTAssertEqual(font, UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont(name: "Courier", size: UIFont.labelFontSize)!))
    }

    func testBodyFont_withDefaultFont_andUseStaticSizeTrue_returnsProperFont() {
        let font = UIFont.bodyFont(forFontFamily: nil, useStaticSize: true)
        XCTAssertEqual(font, UIFont.systemFont(ofSize: UIFont.labelFontSize))
    }

    func testBodyFont_withDefaultFont_andUseStaticSizeFalse_returnsProperFont() {
        let font = UIFont.bodyFont(forFontFamily: nil, useStaticSize: false)
        XCTAssertEqual(font, UIFont.preferredFont(forTextStyle: .body))
    }

    // MARK: - headlineFont

    func testHeadlineFont_withCustomFont_andUseStaticSizeTrue_returnsProperFont() {
        let font = UIFont.headlineFont(forFontFamily: "Courier", useStaticSize: true)
        XCTAssertEqual(font, UIFont(name: "Courier", size: UIFont.labelFontSize)) //TODO this looks wrong
    }

    func testHeadlineFont_withCustomFont_andUseStaticSizeFalse_returnsProperFont() {
        let font = UIFont.headlineFont(forFontFamily: "Courier", useStaticSize: false)
        XCTAssertEqual(font, UIFontMetrics(forTextStyle: .headline).scaledFont(for: UIFont(name: "Courier", size: UIFont.labelFontSize)!))
    }

    func testHeadlineFont_withDefaultFont_andUseStaticSizeTrue_returnsProperFont() {
        let font = UIFont.headlineFont(forFontFamily: nil, useStaticSize: true)
        XCTAssertEqual(font, UIFont.boldSystemFont(ofSize: UIFont.labelFontSize))
    }

    func testHeadlineFont_withDefaultFont_andUseStaticSizeFalse_returnsProperFont() {
        let font = UIFont.headlineFont(forFontFamily: nil, useStaticSize: false)
        XCTAssertEqual(font, UIFont.preferredFont(forTextStyle: .headline))
    }

    // MARK: - captionFont

    func testCaptionFont_withCustomFont_andUseStaticSizeTrue_returnsProperFont() {
        let font = UIFont.captionFont(forFontFamily: "Courier", useStaticSize: true)
        XCTAssertEqual(font, UIFont(name: "Courier", size: UIFont.smallSystemFontSize))
    }

    func testCaptionFont_withCustomFont_andUseStaticSizeFalse_returnsProperFont() {
        let font = UIFont.captionFont(forFontFamily: "Courier", useStaticSize: false)
        XCTAssertEqual(font, UIFontMetrics(forTextStyle: .caption1).scaledFont(for: UIFont(name: "Courier", size: UIFont.smallSystemFontSize)!))
    }

    func testCaptionFont_withDefaultFont_andUseStaticSizeTrue_returnsProperFont() {
        let font = UIFont.captionFont(forFontFamily: nil, useStaticSize: true)
        XCTAssertEqual(font, UIFont.systemFont(ofSize: UIFont.smallSystemFontSize))
    }

    func testCaptionFont_withDefaultFont_andUseStaticSizeFalse_returnsProperFont() {
        let font = UIFont.captionFont(forFontFamily: nil, useStaticSize: false)
        XCTAssertEqual(font, UIFont.preferredFont(forTextStyle: .caption1))
    }

    // MARK: - titleFont

    func testTitleFont_withCustomFont_andUseStaticSizeTrue_returnsProperFont() {
        let font = UIFont.titleFont(forFontFamily: "Courier", useStaticSize: true)
        XCTAssertEqual(font, UIFont(name: "Courier", size: 24))
    }

    func testTitleFont_withCustomFont_andUseStaticSizeFalse_returnsProperFont() {
        let font = UIFont.titleFont(forFontFamily: "Courier", useStaticSize: false)
        XCTAssertEqual(font, UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont(name: "Courier", size: 24)!))
    }

    func testTitleFont_withDefaultFont_andUseStaticSizeTrue_returnsProperFont() {
        let font = UIFont.titleFont(forFontFamily: nil, useStaticSize: true)
        XCTAssertEqual(font, UIFont.systemFont(ofSize: 24))
    }

    func testTitleFont_withDefaultFont_andUseStaticSizeFalse_returnsProperFont() {
        let font = UIFont.titleFont(forFontFamily: nil, useStaticSize: false)
        XCTAssertEqual(font, UIFont.preferredFont(forTextStyle: .title2))
    }
}
