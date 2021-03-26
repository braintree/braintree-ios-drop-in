import BraintreeDropIn

class DemoDropInView: UIView {

    var paymentMethodTypeIcon : UIView? {
        didSet {
            paymentMethodTypeIcon?.widthAnchor.constraint(equalToConstant: 45).isActive = true
            paymentMethodTypeIcon?.heightAnchor.constraint(equalToConstant: 29).isActive = true
            if let oldIcon = oldValue {
                self.paymentMethodStackView.removeArrangedSubview(oldIcon)
                oldIcon.removeFromSuperview()
            }
            if let icon = paymentMethodTypeIcon {
                self.paymentMethodStackView.insertArrangedSubview(icon, at: 0)
            }
        }
    }
    var paymentMethodTypeLabel = UILabel()
    var paymentMethodStackView = UIStackView()
    var dropInButton = UIButton()
    var purchaseButton = UIButton()

    private var secondaryLabelColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor.gray
        }
    }()
    
    init() {
        super.init(frame: CGRect.zero)

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

        paymentMethodStackView = UIStackView(arrangedSubviews: [paymentMethodTypeLabel])
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

        dropInButton.setTitle(NSLocalizedString("Add Payment Method", comment: ""), for: .normal)
        dropInButton.setTitleColor(tintColor, for: .normal)

        purchaseButton.setTitle(NSLocalizedString("Complete Purchase", comment: ""), for: .normal)
        purchaseButton.setTitleColor(UIColor.white, for: .normal)
        purchaseButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .highlighted)
        purchaseButton.backgroundColor = tintColor
        purchaseButton.layer.cornerRadius = 4.0

        let stackView = UIStackView(arrangedSubviews: [
            cartStackView,
            dropInButton,
            purchaseButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
