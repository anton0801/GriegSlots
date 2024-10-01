import SwiftUI
import SpriteKit

struct AppollonianSlotGameView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var slotsRang: SlotsAchivementsManager
    @EnvironmentObject var userConfig: UserConfig
    @State var slotInfoVisible = false
    @State var alertVisible = false
    var appollonianGameScene = AppollonianSlotsGameScene()
    
    var body: some View {
        ZStack {
            SpriteView(scene: appollonianGameScene)
                .ignoresSafeArea()
            
            if slotInfoVisible {
                AppollonianSlotInfoGameView()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("go_home")), perform: { _ in
            userConfig.coins = UserDefaults.standard.integer(forKey: Keys.userCoins)
            presMode.wrappedValue.dismiss()
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("user_balance_low")), perform: { _ in
            alertVisible = true
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("go_info")), perform: { _ in
            userConfig.coins = UserDefaults.standard.integer(forKey: Keys.userCoins)
            withAnimation(.easeIn) {
                slotInfoVisible = true
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("close_info")), perform: { _ in
            withAnimation(.easeOut) {
                slotInfoVisible = false
            }
        })
        .alert(isPresented: $alertVisible, content: {
            Alert(title: Text("Not enought coins on balance!"),
            message: Text("Reduce the bet please!"),
                  dismissButton: .default(Text("Ok")))
        })
    }
    
}

#Preview {
    AppollonianSlotGameView()
        .environmentObject(UserConfig())
        .environmentObject(SlotsAchivementsManager())
}
