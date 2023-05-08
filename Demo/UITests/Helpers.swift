import XCTest

extension XCTestCase {

    func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 15) {
        let existsPredicate = NSPredicate(format: "exists == true")

        expectation(for: existsPredicate, evaluatedWith: element)

        waitForExpectations(timeout: timeout)
    }

    func waitForElementToBeHittable(_ element: XCUIElement, timeout: TimeInterval = 15) {
        let existsPredicate = NSPredicate(format: "exists == true && hittable == true")

        expectation(for: existsPredicate, evaluatedWith: element)

        waitForExpectations(timeout: timeout)
    }
}

extension XCUIElement {

    func forceTapElement() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
            coordinate.tap()
        }
    }
}

extension Date {
    
    static let nextYear: String = {
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy"
        return dateFormatter.string(from: calendar.date(byAdding: .year, value: 1, to: date)!)
    }()

    static let threeYearsFromNow: String = {
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy"
        return dateFormatter.string(from: calendar.date(byAdding: .year, value: 3, to: date)!)
    }()
}
