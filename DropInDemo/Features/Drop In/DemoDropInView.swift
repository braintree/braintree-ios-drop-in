import UIKit

class DemoDropInView: UIView {
    
    var paymentMethodTypeIcon = BTUIKPaymentOptionCardView()
    var paymentMethodTypeLabel = UILabel()
    var dropInButton = UIButton()
    var purchaseButton = UIButton()
    var colorSchemeSegmentedControl = UISegmentedControl()

    private var cartLabel = UILabel()
    private var itemLabel = UILabel()
    private var priceLabel = UILabel()
    private var paymentMethodHeaderLabel = UILabel()
    private var colorSchemeLabel = UILabel()
    
    private var checkoutConstraints: [NSLayoutConstraint] = []
    
    private var secondaryLabelColor: UIColor = {
        if #available(iOS 13, *) {
            return UIColor.secondaryLabel
        } else {
            return UIColor.gray
        }
    }()
    
    func setUpSubviews() {
        cartLabel.text = NSLocalizedString("CART", comment: "")
        cartLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        cartLabel.textColor = secondaryLabelColor
        cartLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cartLabel)
        
        itemLabel.text = NSLocalizedString("1 Sock", comment: "")
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(itemLabel)
        
        priceLabel.text = NSLocalizedString("$10", comment: "")
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(priceLabel)
        
        paymentMethodHeaderLabel.text = NSLocalizedString("PAYMENT METHODS", comment: "")
        paymentMethodHeaderLabel.textColor = secondaryLabelColor
        paymentMethodHeaderLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        paymentMethodHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(paymentMethodHeaderLabel)
        
        dropInButton.setTitle(NSLocalizedString("Select Payment Method", comment: ""), for: .normal)
        dropInButton.setTitleColor(tintColor, for: .normal)
        dropInButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dropInButton)
        
        purchaseButton.setTitle(NSLocalizedString("Complete Purchase", comment: ""), for: .normal)
        purchaseButton.setTitleColor(UIColor.white, for: .normal)
        purchaseButton.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .highlighted)
        purchaseButton.backgroundColor = tintColor
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.layer.cornerRadius = 4.0
        addSubview(purchaseButton)
        
        paymentMethodTypeIcon.isHidden = true
        paymentMethodTypeIcon.translatesAutoresizingMaskIntoConstraints = false
        addSubview(paymentMethodTypeIcon)
        
        paymentMethodTypeLabel.isHidden = true
        paymentMethodTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(paymentMethodTypeLabel)
        
        colorSchemeLabel.text = NSLocalizedString("COLOR SCHEME", comment: "")
        colorSchemeLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        colorSchemeLabel.textColor = secondaryLabelColor
        colorSchemeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorSchemeLabel)
        
        let colorSchemes: [String]
        if #available(iOS 13, *) {
            colorSchemes = ["Light", "Dark", "Dynamic"]
        } else {
            colorSchemes = ["Light", "Dark"]
        }
        
        colorSchemeSegmentedControl = UISegmentedControl(items: colorSchemes)
        colorSchemeSegmentedControl.selectedSegmentIndex = DemoSettings.colorSchemeSetting.rawValue
        colorSchemeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorSchemeSegmentedControl)
    }
    
    func updatePaymentMethodConstraints() {
        NSLayoutConstraint.deactivate(checkoutConstraints)
        
        let viewBindings: [String : Any] = [
            "cartLabel": cartLabel,
            "itemLabel": itemLabel,
            "priceLabel": priceLabel,
            "paymentMethodHeaderLabel": paymentMethodHeaderLabel,
            "dropInButton": dropInButton,
            "paymentMethodTypeIcon": paymentMethodTypeIcon,
            "paymentMethodTypeLabel": paymentMethodTypeLabel,
            "purchaseButton":purchaseButton,
            "colorSchemeLabel": colorSchemeLabel,
            "colorSchemeSegmentedControl":colorSchemeSegmentedControl
        ]
        
        var newConstraints: [NSLayoutConstraint] = []

        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[cartLabel]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[purchaseButton]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-(20)-[cartLabel]-[itemLabel]-[paymentMethodHeaderLabel]", options: .alignAllLeft, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[itemLabel]-[priceLabel]-|", options: .alignAllTop, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[paymentMethodHeaderLabel]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[colorSchemeLabel]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
        
        if !paymentMethodTypeIcon.isHidden && !paymentMethodTypeLabel.isHidden {
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[paymentMethodHeaderLabel]-[paymentMethodTypeIcon(29)]-[dropInButton]", options: .alignAllLeft, metrics: nil, views: viewBindings)
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[paymentMethodTypeIcon(45)]-[paymentMethodTypeLabel]", options: .alignAllCenterY, metrics: nil, views: viewBindings)
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dropInButton]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
            
            dropInButton.setTitle(NSLocalizedString("Change Payment Method", comment: ""), for: .normal)
            purchaseButton.backgroundColor = tintColor
            purchaseButton.isEnabled = true
        } else {
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[paymentMethodHeaderLabel]-[dropInButton]", options: .alignAllLeft, metrics: nil, views: viewBindings)
            newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[dropInButton]-|", options: .alignAllLeft, metrics: nil, views: viewBindings)
            
            dropInButton.setTitle(NSLocalizedString("Add Payment Method", comment: ""), for: .normal)
            purchaseButton.backgroundColor = secondaryLabelColor
            purchaseButton.isEnabled = false
        }
        
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[dropInButton]-(20)-[purchaseButton]-(20)-[colorSchemeLabel]-[colorSchemeSegmentedControl]", options: .alignAllLeft, metrics:nil, views: viewBindings)
        newConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[colorSchemeSegmentedControl]-|", options: .alignAllLeft, metrics:nil, views: viewBindings)
        
        checkoutConstraints = newConstraints
        addConstraints(checkoutConstraints)
    }
}
