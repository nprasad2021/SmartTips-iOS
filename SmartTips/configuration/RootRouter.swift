import UIKit

let storyboardMapIdentifier: String = "main"

class RootRouter {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func presentInitialViewController() {
        let view = TabBarRouter.assemble()
        setRootViewController(view, animated: false)
    }
    
    private func setRootViewController(_ controller: UIViewController, animated: Bool) {
        guard let view = window.rootViewController?.view, animated else {
            window.rootViewController = controller
            window.makeKeyAndVisible()
            return
        }
        
        UIView.transition(from: view,
                          to: controller.view,
                          duration: 0.7, // pay attention on animation & completion block
            options: UIViewAnimationOptions.transitionCrossDissolve,
            completion: { _ in self.window.rootViewController = controller })
    }
}
