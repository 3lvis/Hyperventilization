import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let controller = UINavigationController(rootViewController: OnboardingViewController())
        controller.isNavigationBarHidden = true
        controller.view.backgroundColor = UIColor(hex: "F9603A")
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()

        return true
    }
}
