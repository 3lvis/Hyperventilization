import UIKit

class HyperventilizationViewController: UIViewController {
    lazy var repeatCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .orange
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()

    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "star2")
        return view
    }()

    lazy var displayLink: CADisplayLink = {
        let link = CADisplayLink(target: self, selector: #selector(updateLabel))
        link.preferredFramesPerSecond = 60
        return link
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    var phases = [3, 6, 12, 24, 48, 96]

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.backgroundColor = .white
        view.addSubview(self.imageView)
        view.addSubview(repeatCountLabel)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            repeatCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            repeatCountLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            ])
        animate(fromValue: 0.2, duration: 2, repeatCount: 2)
        rotate()

        displayLink.add(to: RunLoop.current, forMode: .defaultRunLoopMode)
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

    @objc func updateLabel() {
        repeatCountLabel.text = "\(pulseAnimation.repeatCount)"
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

        if repeatCount > 10 {
            animate(fromValue: 0.2, duration: CGFloat(anim.duration), repeatCount: CGFloat(anim.repeatCount))
        } else {
            if let currentScale = imageView.layer.presentation()?.value(forKey: "transform.scale") as? NSNumber {
                animate(fromValue: CGFloat(currentScale.floatValue), duration: CGFloat(duration / 1.5), repeatCount: CGFloat(repeatCount))
            } else {
                animate(fromValue: 0.2, duration: CGFloat(duration / 1.5), repeatCount: CGFloat(repeatCount))
            }
        }
    }
}
