import SwiftUI
import SpriteKit

struct SpinGameView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var userConfig: UserConfig
    
    var body: some View {
        VStack {
            SpriteView(scene: SpinGameScene())
                .ignoresSafeArea()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("go_home")), perform: { _ in
            presMode.wrappedValue.dismiss()
            userConfig.coins = UserDefaults.standard.integer(forKey: Keys.userCoins)
        })
    }
}

#Preview {
    SpinGameView()
        .environmentObject(UserConfig())
}
