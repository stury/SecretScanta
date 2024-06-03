import Foundation

struct UserDefaultsHelper {
    let defaults = UserDefaults.standard
    
    func storeData(_ data: Data, key: String) {
        defaults.set(data, forKey: key)
    }
    
    func retrieveData(_ key: String) -> Data? {
        let result = defaults.object(forKey: key) as? Data
        return result
    }
}
