import XCTest

class BTUIKCardholderNameFormFieldTests: XCTestCase {

    func testValid_whenNotRequired_returnsTrue() {
        let formField = BTUIKCardholderNameFormField()
        XCTAssertTrue(formField.valid)
    }

    func testValid_whenNotRequired_andCardholderNameContainsOnlyWhitespace_returnsTrue() {
        let formField = BTUIKCardholderNameFormField()
        formField.textField.text = "  "
        XCTAssertTrue(formField.valid)
    }

    func testValid_whenRequired_andCardholderNameContainsNonWhitespaceChars_returnsTrue() {
        let formField = BTUIKCardholderNameFormField()
        formField.textField.text = "Brian Tree 123"
        XCTAssertTrue(formField.valid)
    }

    func testValid_whenRequired_andCardholderNameContainsOnlyWhitespace_returnsFalse() {
        let formField = BTUIKCardholderNameFormField()
        formField.textField.text = "  "
        formField.isRequired = true
        XCTAssertFalse(formField.valid)
    }

    func testValid_whenCardholderNameLooksLikeCardNumber_returnsFalse() {
        let formField = BTUIKCardholderNameFormField()
        formField.textField.text = "4111-1111-1111 1111"
        XCTAssertFalse(formField.valid)
    }

    func testValid_whenLongerThan255Chars_returnsFalse() {
        let formField = BTUIKCardholderNameFormField()
        formField.textField.text = "this name is 256 chracters aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        XCTAssertFalse(formField.valid)
    }


}
