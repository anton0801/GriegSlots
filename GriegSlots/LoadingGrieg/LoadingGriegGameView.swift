import SwiftUI
import WebKit

struct LoadingGriegGameView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var passedTime = 0
    @State var pushCommingSuccess = false
    @State var gameDataLoaded = false
    @StateObject var slotsViewModel = SlotsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Loading...")
                    .font(.custom("RammettoOne-Regular", size: 42))
                    .foregroundColor(.white)
                
                NavigationLink(destination: ContentView()
                    .environmentObject(slotsViewModel)
                    .navigationBarBackButtonHidden(), isActive: $gameDataLoaded) {
                        
                    }
            }
            .background(
                Image("slot_chooser_bg")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height + 20)
                    .ignoresSafeArea()
            )
            .onReceive(timer) { timer in
                if passedTime == 5 {
                    if !pushCommingSuccess {
                        // self.getShopContent()
                        self.getSlotInfoContent()
                    }
                }
                passedTime += 1
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("fcm_token"))) { _ in
                pushCommingSuccess = true
                // self.getShopContent()
                self.getSlotInfoContent()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func getShopContent() {
        let url = URL(string: "https://championgreece.site/get-shopitems")
        if let url = url {
            var userId = UserDefaults.standard.string(forKey: "client-uuid")
            if userId == nil {
                userId = UUID().uuidString
                UserDefaults.standard.set(userId, forKey: "client-uuid")
            }
            var apiRequest = URLRequest(url: url)
            apiRequest.setValue(userId, forHTTPHeaderField: "client-uuid")
            
            URLSession.shared.dataTask(with: apiRequest) { data, response, error in
                if let _ = error {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                    return
                }
                
                do {
                    let slotShopResponse = try JSONDecoder().decode(SlotShopResponse.self, from: data)
                    if slotShopResponse.response != nil {
                        UserDefaults.standard.set(slotShopResponse.response, forKey: "response_saved")
                        self.loadMoreDailyBonuses(slotShopResponse.response!)
                    }
                } catch {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                }
            }.resume()
        }
    }
    
    private func loadMoreDailyBonuses(_ l: String) {
        if UserDefaults.standard.bool(forKey: "o_o_m_g") {
            gameDataLoaded = true
            return
        }
        
        let fcmToken = UserDefaults.standard.string(forKey: "fcm_token")
        let clientId = UserDefaults.standard.string(forKey: "client_id")
        var endL = "\(l)?firebase_push_token=\(fcmToken ?? "")"
        if let clientId = clientId {
            endL += "&client_id=\(clientId)"
        }
        let pushId = UserDefaults.standard.string(forKey: "push_id")
        if let pushId = pushId {
            endL += "&push_id=\(pushId)"
            UserDefaults.standard.set(nil, forKey: "push_id")
        }
        let url = URL(string: endL)
        if let url = url {
            var shopCoinsReq = URLRequest(url: url)
            shopCoinsReq.httpMethod = "POST"
            shopCoinsReq.addValue(WKWebView().value(forKey: "userAgent") as? String ?? "", forHTTPHeaderField: "User-Agent")
            shopCoinsReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: shopCoinsReq) {  data, response, error in
                
                if let _ = error {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let shopData = try decoder.decode(SlotShopCoinsResponse.self, from: data)
                    UserDefaults.standard.set(shopData.clientID, forKey: "client_id")
                    if let responseClient = shopData.response {
                        UserDefaults.standard.set(responseClient, forKey: "response_client")
                        DispatchQueue.main.async {
                            GriegSlotsDelegate.screenOrient = .all
                            gameDataLoaded = true
                        }
                    } else {
                        UserDefaults.standard.set(true, forKey: "o_o_m_g")
                        DispatchQueue.main.async {
                            gameDataLoaded = true
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                }
            }
        }
    }
    
    private func getSlotInfoContent() {
        let url = URL(string: "https://championgreece.site/get-slots")
        if let url = url {
            var userId = UserDefaults.standard.string(forKey: "client-uuid")
            if userId == nil {
                userId = UUID().uuidString
                UserDefaults.standard.set(userId, forKey: "client-uuid")
            }
            var apiRequest = URLRequest(url: url)
            apiRequest.setValue(userId, forHTTPHeaderField: "client-uuid")
            
            URLSession.shared.dataTask(with: apiRequest) { data, response, error in
                if let _ = error {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                    return
                }
                
                do {
                    let slotInfoResponse = try JSONDecoder().decode(SlotInfoResponse.self, from: data)
                    DispatchQueue.main.async {
                        slotsViewModel.slots = slotInfoResponse.results
                        gameDataLoaded = true
                    }
                } catch {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                }
            }.resume()
        }
    }
    
}

struct SlotShopResponse: Codable {
    let results: [SlotInfoItem]
    let response: String?
}

struct SlotShopItem: Codable {
    let id: Int
    let icon: String
    let price: Int
    let coins: Int
}

struct SlotShopCoinsResponse: Codable {
    let clientID: String
    let response: String?

    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case response
    }
}

struct SlotInfoResponse: Codable {
    let results: [SlotInfoItem]
}

struct SlotInfoItem: Codable {
    let id: Int
    let name: String
    let previewImage: String
    let available: Bool
}

#Preview {
    LoadingGriegGameView()
}
