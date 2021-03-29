import UIKit

class DemoPurchaseButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        setTitle(NSLocalizedString("Purchase", comment: ""), for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = tintColor
        layer.cornerRadius = 4.0
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
