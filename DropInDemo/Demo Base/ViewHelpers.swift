import UIKit

extension UIView {
    
    func pinToEdges(of viewController: UIViewController) {
        translatesAutoresizingMaskIntoConstraints = false

        let safeAreaLayoutGuide = viewController.view.safeAreaLayoutGuide
        
        leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
