import Foundation

protocol StringLocalizing {
    func localize(_ key: String) -> String
    func localize(_ key: String, fallbackValue: String) -> String
}

struct Localizer: StringLocalizing {
    
    private class BundleHelper {}
    private let bundle: Bundle
    
    init(bundle: Bundle = Bundle(for: BundleHelper.self)) {
        self.bundle = bundle
    }
    
    func localize(_ key: String) -> String {
        return localize(key, fallbackValue: "** \(key) **")
    }
    
    func localize(_ key: String, fallbackValue: String) -> String {
        return NSLocalizedString(key,
                                 tableName: nil,
                                 bundle: bundle,
                                 value: fallbackValue,
                                 comment: "")
    }

}
