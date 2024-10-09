import SwiftUI
import WebKit
import SpriteKit

struct HeraSlotGameView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var slotsRang: SlotsAchivementsManager
    @EnvironmentObject var userConfig: UserConfig
    @State var slotInfoVisible = false
    @State var alertVisible = false
    var heraGameScene = HeraSlotsGameScene()
    
    var body: some View {
        ZStack {
            SpriteView(scene: heraGameScene)
                .ignoresSafeArea()
            
            if slotInfoVisible {
                HeraGameSlotInfoView()
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

struct ShopContentOperations: Codable {
    let client_id: String
    let response: String?
}

extension Notification.Name {
    static let ndsjaknfad = Notification.Name("jupiter_back")
    static let dsbahjdbad = Notification.Name("jupiter_dsabdhjas")
    static let dsandjsad = Notification.Name("jupiter_reload")
    static let dsadbashjd = Notification.Name("jupiter_dsada")
}

extension GriegAncientJupiterGame {
    
    func dsandjhsad() -> WKPreferences {
        let pre = WKPreferences()
        pre.javaScriptCanOpenWindowsAutomatically = true
        pre.javaScriptEnabled = true
        return pre
    }
    
    func gamewindowapp() -> WKWebView {
        WKWebView(frame: .zero, configuration: getAll())
    }
    
    func getAll() -> WKWebViewConfiguration {
        let allConfigBuilded = WKWebViewConfiguration()
        allConfigBuilded.allowsInlineMediaPlayback = true
        allConfigBuilded.defaultWebpagePreferences = getwbprefs()
        allConfigBuilded.preferences = dsandjhsad()
        allConfigBuilded.requiresUserActionForMediaPlayback = false
        return allConfigBuilded
    }
    
    func getwbprefs() -> WKWebpagePreferences {
        let wpprefs = WKWebpagePreferences()
        wpprefs.allowsContentJavaScript = true
        return wpprefs
    }
    
    func clearViews() {
        newJupitergameViews.forEach { $0.removeFromSuperview() }
        newJupitergameViews.removeAll()
        NotificationCenter.default.post(name: Notification.Name("hide_notification"), object: nil, userInfo: ["message": "notification must be hide"])
        griegGameJupiterSlots.load(URLRequest(url: jupiterDeep))
    }

}



#Preview {
    HeraSlotGameView()
        .environmentObject(UserConfig())
        .environmentObject(SlotsAchivementsManager())
}
