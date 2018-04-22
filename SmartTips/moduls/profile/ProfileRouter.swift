import UIKit

class ProfileRouter: RouterContract {
    weak var view: UIViewController?
    
    static func assembleCustomer() -> UIViewController {
        let router = ProfileRouter()
        guard let view = UIStoryboard(name: storyboardMapIdentifier, bundle: Bundle.main).instantiateViewController(withIdentifier: "profile") as? ProfileViewController else { fatalError() }
//        view.router = router
        view.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "circle"), selectedImage: nil)
        router.view = view
        return view
    }
    
    static func assembleWaiter() -> UIViewController {
        fatalError()
    }
}
