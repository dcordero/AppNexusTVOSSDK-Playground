import UIKit

final class ModalViewController: UIViewController {
    
    private var closeButton: UIButton!
    
    override func viewDidLoad() {
        closeButton = UIButton()
        closeButton.setTitle("Press .select to dismiss the modal", for: .normal)
        closeButton.addTarget(self, action: #selector(closeViewController), for: .primaryActionTriggered)
        view.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        closeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc
    func closeViewController() {
        dismiss(animated: true)
    }
}
