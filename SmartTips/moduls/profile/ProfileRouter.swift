import UIKit

class ProfileRouter: RouterContract {
    weak var view: UIViewController?
    
    static func assembleCustomer() -> UIViewController {
        fatalError()
    }
    
    static func assembleWaiter() -> UIViewController {
        fatalError()
    }
}
