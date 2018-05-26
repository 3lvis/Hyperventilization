import UIKit

class HyperventilizationViewController: UIViewController {
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "star2")
        return view
    }()

    lazy var instructionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Oswald-SemiBold", size: 35)
        label.textColor = UIColor(hex: "F9603A")
        label.text = "Breathe".uppercased()
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(instructionsLabel)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            instructionsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])

        animate(fromValue: 0.2, duration: 2, repeatCount: 2)
        rotate()

        perform(#selector(fadeLabel), with: nil, afterDelay: 3)
    }

    @objc func fadeLabel() {
        UIView.animate(withDuration: 0.4) {
            self.instructionsLabel.alpha = 0
        }
    }

    var pulseAnimation: CABasicAnimation!
    func animate(fromValue: CGFloat, duration: CGFloat, repeatCount: CGFloat) {
        pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = CFTimeInterval(duration)
        pulseAnimation.isAdditive = true
        pulseAnimation.fromValue = NSNumber(value: Double(fromValue))
        pulseAnimation.byValue = NSNumber(value: 0.2)
        pulseAnimation.toValue = NSNumber(value: 1.0)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float(repeatCount)
        pulseAnimation.delegate = self
        imageView.layer.add(pulseAnimation, forKey: "pulse")
    }

    func rotate() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        pulseAnimation.isAdditive = true
        pulseAnimation.duration = 100.0
        pulseAnimation.fromValue = NSNumber(value: 0)
        pulseAnimation.toValue = NSNumber(value: 45)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        imageView.layer.add(pulseAnimation, forKey: nil)
    }
}

extension HyperventilizationViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("start")
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("stop")
        let duration = anim.duration
        print("duration: \(duration)")
        imageView.layer.removeAnimation(forKey: "pulse")
        let repeatCount = anim.repeatCount * 1.5
        print("repeatCount: \(repeatCount)")

        if repeatCount > 30 {
            animate(fromValue: 0.2, duration: CGFloat(anim.duration), repeatCount: CGFloat(anim.repeatCount))
        } else {
            animate(fromValue: 0.2, duration: CGFloat(duration / 1.5), repeatCount: CGFloat(repeatCount))
        }
    }
}
