import UIKit

class TabBarViewController: UITabBarController {
    private let router: TabBarRouter
    
    init(router: TabBarRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedIndex = 1
        selectedViewController = viewControllers?[1]
        selectedIndex = 0
        selectedViewController = viewControllers?[0]
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    
}
