import UIKit

class HyperventilizationViewController: UIViewController {
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "star2")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.backgroundColor = .white
        view.addSubview(self.imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        animate(duration: 3, repeatCount: 3)
        rotate()
    }

    func animate(duration: CGFloat, repeatCount: CGFloat) {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = CFTimeInterval(duration)
        pulseAnimation.isAdditive = true
        pulseAnimation.fromValue = NSNumber(value: 0.2)
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
        let repeatCount = anim.repeatCount * 2
        animate(duration: CGFloat(duration / 2), repeatCount: CGFloat(repeatCount))
    }
}
