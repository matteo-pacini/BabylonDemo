import UIKit
import Core

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var configuration: ConfigurationType!
    private var coordinatorFactory: CoordinatorFactoryType!
    private var appCoordinator: AppCoordinatorType!
    private var repository: RepositoryType!
    private var webservice: WebserviceType!

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else {
            fatalError("No window")
        }

        guard NSClassFromString("XCTest") == nil else {
            return true
        }
                
        configuration = Configuration()
        
        let baseWebservice = Webservice(baseURL: configuration.baseURL)
        webservice = CachedWebservice(decorated: baseWebservice, storage: UserDefaults.standard)
        repository = Repository(webservice: webservice)
        
        coordinatorFactory = CoordinatorFactory(repository: repository)
        
        appCoordinator = coordinatorFactory.makeApp()
        appCoordinator.start(on: window)
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        webservice.clear()
        
    }
}
