import Foundation

public protocol ConfigurationType {
    var baseURL: URL { get }
}

public final class Configuration: ConfigurationType {
    
    public var baseURL: URL {
        guard let baseURLString = info["baseURL"] as? String else {
            fatalError("Could not read \"baseURL\"!")
        }
        guard let url = URL(string: baseURLString) else {
            fatalError("\(baseURLString) is not a valid URL!")
        }
        return url
    }
    
    private let info: [String: AnyHashable]
    
    public init() {
        guard let infoPlist = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("No Info.plist!")
        }
        guard let info = NSDictionary(contentsOfFile: infoPlist) as? Dictionary<String, AnyHashable> else {
            fatalError("Could not read Info.plist!")
        }
        self.info = info
    }
    
}
