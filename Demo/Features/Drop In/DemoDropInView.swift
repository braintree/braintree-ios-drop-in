import BraintreeDropIn

class DemoDropInView: UIView {
    
    var paymentMethodTypeIcon = BTUIKPaymentOptionCardView()
    var paymentMethodTypeLabel = UILabel()
    var dropInButton = UIButton()
    var purchaseButton = UIButton()
    var colorSchemeSegmentedControl = UISegmentedControl()

    private var checkoutConstraints: [NSLayoutConstraint] = []
    
    private var secondaryLabelColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor.gray
        }
    }()
    
    func setUpSubviews() {
        let cartLabel = UILabel()
        cartLabel.text = NSLocalizedString("CART", comment: "")
        cartLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        cartLabel.textColor = secondaryLabelColor

        let itemLabel = UILabel()
        itemLabel.text = NSLocalizedString("1 Sock", comment: "")

        let priceLabel = UILabel()
        priceLabel.text = NSLocalizedString("$10", comment: "")

        let itemStackView = UIStackView(arrangedSubviews: [itemLabel, priceLabel])
        itemStackView.axis = .horizontal
        itemStackView.distribution = .equalSpacing

        let paymentMethodHeaderLabel = UILabel()
        paymentMethodHeaderLabel.text = NSLocalizedString("PAYMENT METHODS", comment: "")
        paymentMethodHeaderLabel.textColor = secondaryLabelColor
        paymentMethodHeaderLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)

        paymentMethodTypeIcon.isHidden = true
        paymentMethodTypeLabel.isHidden = true

        let paymentMethodStackView = UIStackView(arrangedSubviews: [paymentMethodTypeIcon, paymentMethodTypeLabel])
        paymentMethodStackView.axis = .horizontal
        paymentMethodStackView.spacing = 8

        let cartStackView = UIStackView(arrangedSubviews: [
            cartLabel,
            itemStackView,
            paymentMethodHeaderLabel,
            paymentMethodStackView
        ])
        cartStackView.axis = .vertical
        cartStackView.spacing = 10

        dropInButton.setTitle(NSLocalizedString("Select Payment Method", comment: ""), for: .normal)
        dropInButton.setTitleColor(tintColor, for: .normal)

        purchaseButton.setTitle(NSLocalizedString("Complete Purchase", comment: ""), for: .normal)
        purchaseButton.setTitleColor(UIColor.white, for: .normal)
        purchaseButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .highlighted)
        purchaseButton.backgroundColor = tintColor
        purchaseButton.layer.cornerRadius = 4.0

        let colorSchemeLabel = UILabel()
        colorSchemeLabel.text = NSLocalizedString("COLOR SCHEME", comment: "")
        colorSchemeLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        colorSchemeLabel.textColor = secondaryLabelColor

        var colorSchemes = ["Light", "Dark"]
        if #available(iOS 13, *) {
            colorSchemes += ["Dynamic"]
        }
        
        colorSchemeSegmentedControl = UISegmentedControl(items: colorSchemes)
        colorSchemeSegmentedControl.selectedSegmentIndex = DemoSettings.colorSchemeSetting.rawValue

        let colorSchemeStackView = UIStackView(arrangedSubviews: [
            colorSchemeLabel,
            colorSchemeSegmentedControl
        ])
        colorSchemeStackView.axis = .vertical
        colorSchemeStackView.spacing = 10

        let stackView = UIStackView(arrangedSubviews: [
            cartStackView,
            dropInButton,
            purchaseButton,
            colorSchemeStackView
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            paymentMethodTypeIcon.widthAnchor.constraint(equalToConstant: 45),
            paymentMethodTypeIcon.heightAnchor.constraint(equalToConstant: 29)
        ])
    }
}
