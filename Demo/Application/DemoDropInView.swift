import BraintreeDropIn

protocol DemoDropInViewDelegate: class {
    func demoViewDidTapDropInButton(_ view: DemoDropInView)
    func demoViewDidTapPurchaseButton(_ view: DemoDropInView)
}

class DemoDropInView: UIView {

    weak var delegate: DemoDropInViewDelegate?

    var result: BTDropInResult? {
        didSet {
            if let result = result {
                paymentMethodStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })

                let label = UILabel()
                label.text = result.paymentDescription

                let icon = result.paymentIcon
                NSLayoutConstraint.activate([
                    icon.widthAnchor.constraint(equalToConstant: 45),
                    icon.heightAnchor.constraint(equalToConstant: 29)
                ])

                paymentMethodStackView.addArrangedSubview(icon)
                paymentMethodStackView.addArrangedSubview(label)
                paymentMethodStackView.isHidden = false

                dropInButton.setTitle(NSLocalizedString("Change Payment Method", comment: ""), for: .normal)
            } else {
                paymentMethodStackView.isHidden = true
                dropInButton.setTitle(NSLocalizedString("Add Payment Method", comment: ""), for: .normal)
            }

            updatePurchaseButton(result)
        }
    }

    private var purchaseButton: UIButton!
    private let dropInButton = UIButton()
    private let paymentMethodStackView = UIStackView()

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
        priceLabel.setContentHuggingPriority(.required, for: .horizontal)

        let itemStackView = UIStackView(arrangedSubviews: [itemLabel, priceLabel])
        itemStackView.axis = .horizontal
        itemStackView.distribution = .fill

        let paymentMethodHeaderLabel = UILabel()
        paymentMethodHeaderLabel.text = NSLocalizedString("PAYMENT METHOD", comment: "")
        paymentMethodHeaderLabel.textColor = secondaryLabelColor
        paymentMethodHeaderLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)

        paymentMethodStackView.axis = .horizontal
        paymentMethodStackView.spacing = 8
        paymentMethodStackView.isHidden = true

        dropInButton.setTitle(NSLocalizedString("Add Payment Method", comment: ""), for: .normal)
        dropInButton.setTitleColor(tintColor, for: .normal)
        dropInButton.contentHorizontalAlignment = .leading
        dropInButton.addTarget(self, action: #selector(didTapDropInButton), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [
            cartLabel,
            itemStackView,
            paymentMethodHeaderLabel,
            paymentMethodStackView,
            dropInButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
        ])

        updatePurchaseButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updatePurchaseButton(_ result: BTDropInResult? = nil) {
        purchaseButton?.removeFromSuperview()

        switch result?.paymentOptionType {
        case .applePay:
            purchaseButton = PKPaymentButton(paymentButtonType: .checkout, paymentButtonStyle: .black)
        default:
            purchaseButton = DemoPurchaseButton()
            purchaseButton.isEnabled = (result != nil && !result!.isCanceled)
        }

        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(purchaseButton)

        NSLayoutConstraint.activate([
            purchaseButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            purchaseButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            purchaseButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            purchaseButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        purchaseButton.addTarget(self, action: #selector(didTapPurchaseButton), for: .touchUpInside)
    }

    @objc func didTapPurchaseButton() {
        delegate?.demoViewDidTapPurchaseButton(self)
    }

    @objc func didTapDropInButton() {
        delegate?.demoViewDidTapDropInButton(self)
    }
}
