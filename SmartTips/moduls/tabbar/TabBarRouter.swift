import UIKit

class TabBarRouter: RouterContract {
    weak var view: UIViewController?
    
    static func assemble() -> UITabBarController {
        let router = TabBarRouter()
        let view = TabBarViewController(router: router)
        
        let tipsNavigationController = UINavigationController(rootViewController: TipOnboardingViewController())
        let mapNaivgationController = UINavigationController(rootViewController: MapRouter.assemble())
        
        view.viewControllers = [
            tipsNavigationController,
            mapNaivgationController
        ]
        router.view = view
        return view
    }
}
