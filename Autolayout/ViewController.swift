import UIKit

final class ViewController: UIViewController {

    private lazy var firstLabel: UILabel = {
        let element = UILabel()
        element.text = "First Label"
        element.font = UIFont.systemFont(ofSize: 17)
        element.textColor = .black
        element.textAlignment = .center
        element.setContentHuggingPriority(.defaultLow, for: .horizontal)
        element.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var secondLabel: UILabel = {
        let element = UILabel()
        element.text = "Second Label"
        element.font = UIFont.systemFont(ofSize: 17)
        element.textColor = .black
        element.textAlignment = .center
        element.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        element.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "cat")
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Constraints
    private var portraitConstraints: [NSLayoutConstraint] = []
    private var landscapeConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setView()
        setupConstraints()
        activateConstraints()
    }
    
    private func setView() {
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(imageView)
    }
    
    private func setupConstraints() {
        let centerYOffset = min(view.bounds.height / 10, 10)
        
        portraitConstraints = [
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -centerYOffset),
            imageView.bottomAnchor.constraint(lessThanOrEqualTo: firstLabel.topAnchor, constant: -10),
            
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstLabel.trailingAnchor.constraint(equalTo: secondLabel.leadingAnchor, constant: -20),
            firstLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            firstLabel.widthAnchor.constraint(equalTo: secondLabel.widthAnchor)
        ]
        
        landscapeConstraints = [
            firstLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            secondLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            secondLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            firstLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -20),
            imageView.trailingAnchor.constraint(equalTo: secondLabel.leadingAnchor, constant: -20)
        ]
    }
    
    private func activateConstraints() {
        if UIDevice.current.orientation.isPortrait {
            NSLayoutConstraint.deactivate(landscapeConstraints)
            NSLayoutConstraint.activate(portraitConstraints)
        } else {
            NSLayoutConstraint.deactivate(portraitConstraints)
            NSLayoutConstraint.activate(landscapeConstraints)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.activateConstraints()
        }, completion: nil)
    }
}
