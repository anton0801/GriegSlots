import Foundation

class Keys {
    static let userCoins = "userdata_coins"
}

class UserConfig: ObservableObject {
    
    @Published var coins = UserDefaults.standard.integer(forKey: Keys.userCoins) {
        didSet {
            UserDefaults.standard.set(coins, forKey: Keys.userCoins)
        }
    }
    
}
