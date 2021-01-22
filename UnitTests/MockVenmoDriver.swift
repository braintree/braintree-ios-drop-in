@objcMembers
class MockVenmoDriver: BTVenmoDriver {

    var _isiOSAppAvailableForAppSwitch = false

    override func isiOSAppAvailableForAppSwitch() -> Bool {
        return _isiOSAppAvailableForAppSwitch
    }

}
