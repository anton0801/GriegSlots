import SwiftUI

class SlotsAchivementsManager: ObservableObject {
    @Published var starsForGames: [String: Int] = [:] {
        didSet {
            saveStarsToUserDefaults()
        }
    }
    
    private let userDefaultsKey = "starsForGames"
    
    init() {
        loadStarsFromUserDefaults()
        
        if starsForGames.isEmpty {
            var temp: [String: Int] = [:]
            temp["slot_hera"] = 0
            temp["slot_apollonian"] = 0
            temp["slot_sweet_rome"] = 0
            starsForGames = temp
        }
    }
    
    func updateStars(for game: String, score: Int) {
        guard score >= 10000 else {
            return
        }
        
        let currentStars = starsForGames[game] ?? 0
        
        if currentStars < 5 {
            let newStars = currentStars + 1
            starsForGames[game] = newStars
        }
    }
    
    func resetStars(for game: String) {
        starsForGames[game] = 0
    }
    
    private func saveStarsToUserDefaults() {
        let data = try? JSONEncoder().encode(starsForGames)
        UserDefaults.standard.set(data, forKey: userDefaultsKey)
    }
    
    private func loadStarsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let savedStars = try? JSONDecoder().decode([String: Int].self, from: data) {
            starsForGames = savedStars
        }
    }
}
