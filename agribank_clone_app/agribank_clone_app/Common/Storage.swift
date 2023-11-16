

import Foundation
import UIKit
struct AppData {
    
    @Storage(key: "isLogin", defaultValue: false)
    static var isLogin: Bool
    
    @StorageObject(key: "account", defaultValue: nil)
    static var account: AccountModel?
    
    @StorageObject(key: "listTransaction", defaultValue: [])
    static var listTransaction: [TransferModel]?
    
    
}
extension AppData {
    
    static func logIn() {
        AppData.isLogin = true
        
        DispatchQueue.main.async {
            APP_DELEGATE?.appNavigator?.switchToMain()
        }
    }
    
    static func logout() {
        AppData.isLogin = false
        DispatchQueue.main.async {
            APP_DELEGATE?.appNavigator?.swichToLogin()
        }
    }
}
@propertyWrapper
struct Storage<T> {
    private let key: String
    private let defaultValue: T
    
    private let defaults = UserDefaults.standard
    
    init(key: String = #function, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return defaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                defaults.removeObject(forKey: key)
            } else {
                defaults.set(newValue, forKey: key)
            }
            defaults.synchronize()
        }
    }
}
@propertyWrapper
struct StorageObject<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    private let defaults = UserDefaults.standard
    
    init(key: String = #function, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
            get {
                guard let data = defaults.object(forKey: key) as? Data else {
                    return defaultValue
                }
                let value = try? JSONDecoder().decode(T.self, from: data)
                return value ?? defaultValue
            }
            set {
                do {
                    let data = try JSONEncoder().encode(newValue)
                    defaults.set(data, forKey: key)
                } catch {
                    defaults.removeObject(forKey: key)
                }
            }
        }
}

public protocol AnyOptional {
    var isNil: Bool { get }
}
extension Optional: AnyOptional {
    public var isNil: Bool { self == nil }
}
extension Storage where T: ExpressibleByNilLiteral {
    init(key: String, _ container: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil)
    }
}

