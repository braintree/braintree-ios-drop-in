import UIKit

extension UIView {
    
    func pinToEdges(of viewController: UIViewController) {
        translatesAutoresizingMaskIntoConstraints = false

        let topConstraint = NSLayoutConstraint(item: self,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: viewController.topLayoutGuide,
                                               attribute: .bottom,
                                               multiplier: 1.0,
                                               constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: self,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: viewController.bottomLayoutGuide,
                                                  attribute: .top,
                                                  multiplier: 1.0,
                                                  constant: 0)
        
        let leadingConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: viewController.view,
                                                   attribute: .leading,
                                                   multiplier: 1.0,
                                                   constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: viewController.view,
                                                   attribute: .trailing,
                                                   multiplier: 1.0,
                                                   constant: 0)
        
        
        viewController.view.addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
}
