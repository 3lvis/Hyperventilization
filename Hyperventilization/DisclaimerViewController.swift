import UIKit

//fontFamily: Montez, fonts: ["Montez-Regular"]
//fontFamily: Oswald, fonts: ["Oswald-Regular", "Oswald-SemiBold"]

class DisclaimerViewController: UIViewController {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Disclaimer"
        label.font = UIFont(name: "Oswald-SemiBold", size: 55)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    lazy var moreInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This app causes discomfort and probably fainting. We might record your face and definitely sell your data for profit.".uppercased()
        label.font = UIFont(name: "Oswald-Regular", size: 35)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    lazy var letsGoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 40
        button.setTitle("OK", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont(name: "Oswald-Regular", size: 36)
        button.setTitleColor(UIColor(hex: "F9603A"), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "F9603A")
        view.addSubview(titleLabel)
        view.addSubview(letsGoButton)
        view.addSubview(moreInfoLabel)
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: moreInfoLabel.topAnchor, constant: -30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            moreInfoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            moreInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            moreInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),

            letsGoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letsGoButton.heightAnchor.constraint(equalToConstant: 80),
            letsGoButton.widthAnchor.constraint(equalToConstant: 80),
            letsGoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            ])

        letsGoButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }

    @objc func goNext() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = .white
        }) { (_) in
            let controller = HyperventilizationViewController()
            self.navigationController?.pushViewController(controller, animated: false)
        }
    }
}
