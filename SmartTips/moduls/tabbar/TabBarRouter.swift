import UIKit

class TabBarRouter: RouterContract {
    weak var view: UIViewController?
    
    static func assemble() -> UITabBarController {
        let router = TabBarRouter()
        let view = TabBarViewController(router: router)
        
        view.viewControllers = [
            TipOnboardingViewController(),
            MapRouter.assemble()
        ]
        router.view = view
        return view
    }
}
