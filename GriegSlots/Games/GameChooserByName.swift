import SwiftUI

struct GameChooserByName: View {
    
    var name: String
    @EnvironmentObject var slotsRang: SlotsAchivementsManager
    @EnvironmentObject var userConfig: UserConfig
    
    var body: some View {
        if name == "HERA" {
            HeraSlotGameView()
                .environmentObject(userConfig)
                .environmentObject(slotsRang)
        } else if name == "APPOLLIANIAN" {
            AppollonianSlotGameView()
                .environmentObject(userConfig)
                .environmentObject(slotsRang)
        }
    }
}

#Preview {
    GameChooserByName(name: "HERA")
        .environmentObject(UserConfig())
        .environmentObject(SlotsAchivementsManager())
}
