import UIKit
import NMAKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var router: RootRouter!
    var window: UIWindow?
    
    private let kHelloMapAppID = "wpqy17RvWAkCRGIKRuFE"
    private let kHelloMapAppCode = "zfpnV_IsCCXKfEN91rSZ5g"
}

extension AppDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AppConfigurator.shared.run()
        
        let strongWindow = UIWindow(frame: UIScreen.main.bounds)
        self.window = strongWindow
        router = RootRouter.init(window: strongWindow)
        router.presentInitialViewController()
        
        NMAApplicationContext.set(appId: kHelloMapAppID, appCode: kHelloMapAppCode)
        
        return true
    }
}
