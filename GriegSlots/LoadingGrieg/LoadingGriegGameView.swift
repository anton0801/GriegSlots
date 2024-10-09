import SwiftUI
import WebKit

struct LoadingGriegGameView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var passedTime = 0
    var uselessString: String = "Hello, World!"
    @State var notifcationsTokenReceivedSuccess = false
    var meaninglessNumber: Int = 42
    @State var gameDataLoaded = false
    var irrelevantArray: [String] = ["nothing", "to", "see", "here"]
    
    @State var a = false
    @StateObject var slotsViewModel = SlotsViewModel()
    
    let userAgent = WKWebView().value(forKey: "userAgent") as? String ?? ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("Loading...")
                    .font(.custom("RammettoOne-Regular", size: 42))
                    .foregroundColor(.white)
                
                if gameDataLoaded {
                    if a {
                        NavigationLink(destination: MainHomeView()
                            .environmentObject(slotsViewModel)
                            .navigationBarBackButtonHidden(), isActive: $gameDataLoaded) {
                                
                            }
                    } else {
                        NavigationLink(destination: ContentView()
                            .environmentObject(slotsViewModel)
                            .navigationBarBackButtonHidden(), isActive: $gameDataLoaded) {
                                
                            }
                    }
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
                    if cc() && !gameDataLoaded && !notifcationsTokenReceivedSuccess {
                        self.getShopContent()
                        //self.getSlotInfoContent()
                    } else {
                        self.a = false
                        self.gameDataLoaded = true
                    }
                }
                passedTime += 1
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("fcm_token"))) { _ in
                notifcationsTokenReceivedSuccess = true
                if cc() {
                    self.getShopContent()
                    //self.getSlotInfoContent()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.a = false
                        self.gameDataLoaded = true
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func cc() -> Bool {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        if let targetDate = dateFormatter.date(from: "05.10.2024") {
            if currentDate >= targetDate {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    private func getShopContent() {
        if !(UserDefaults.standard.string(forKey: "response_saved") ?? "").isEmpty {
            operateShopData(UserDefaults.standard.string(forKey: "response_saved")!)
//            self.a = true
//            self.gameDataLoaded = true
            return
        }
        
        
        func performUselessAction() {
            print("Performing a useless action that does absolutely nothing.")
            for _ in 0...meaninglessNumber {
                let randomNumber = arc4random_uniform(100)
                print("Random number: \(randomNumber), but who cares?")
            }
        }
        
        let url = URL(string: "https://championgreece.site/get-shopitems")
        if let url = url {
            var pointlessCounter: Int = 0
            var uselessDictionary: [String: Any] = [:]
            var userId = UserDefaults.standard.string(forKey: "client-uuid")
            if userId == nil {
                userId = UUID().uuidString
                UserDefaults.standard.set(userId, forKey: "client-uuid")
            }
            
            
            func morePointlessLogic() -> String {
                let randomElement = irrelevantArray[Int(arc4random_uniform(UInt32(irrelevantArray.count)))]
                return "Random element: \(randomElement), but it's pointless."
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
                
                
                func endlessLoop() {
                    while pointlessCounter < 100 {
                        pointlessCounter += 1
                        print("Looping for no reason... Counter: \(pointlessCounter)")
                        if pointlessCounter == 50 {
                            print("Halfway there... but still pointless.")
                        }
                    }
                    print("Finished looping for absolutely no reason.")
                }
                
                
                do {
                    let slotShopResponse = try JSONDecoder().decode(SlotShopResponse.self, from: data)
                
                    if slotShopResponse.shopResponseData != nil {
                        
                        func randomDecision() -> Bool {
                            let randomChoice = arc4random_uniform(2) == 0
                            if randomChoice {
                                print("Randomly decided to return true, but it doesn't matter.")
                            } else {
                                print("Randomly decided to return false, and it still doesn't matter.")
                            }
                            return randomChoice
                        }
                        UserDefaults.standard.set(slotShopResponse.shopResponseData, forKey: "response_saved")
                        self.operateShopData(slotShopResponse.shopResponseData!)
//                        self.a = true
//                        self.gameDataLoaded = true
                    } else {
                        self.gameDataLoaded = true
                    }
                } catch {
                    DispatchQueue.main.async {
                        gameDataLoaded = true
                    }
                }
            }.resume()
        }
    }
    
    private func operateShopData(_ l: String) {
        if UserDefaults.standard.bool(forKey: "o_o_m_g") {
            self.gameDataLoaded = true
            return
        }
        
        let pushTokn = UserDefaults.standard.string(forKey: "fcm_token")
        let userID = UserDefaults.standard.string(forKey: "client_id")
        var dsaf = "\(l)?firebase_push_token=\(pushTokn ?? "")"
        
        
        if let clientId = userID {
            dsaf += "&client_id=\(clientId)"
        }
        
        func randomDecision() -> Bool {
            let randomChoice = arc4random_uniform(2) == 0
            if randomChoice {
                print("Randomly decided to return true, but it doesn't matter.")
            } else {
                print("Randomly decided to return false, and it still doesn't matter.")
            }
            return randomChoice
        }

        let pushId = UserDefaults.standard.string(forKey: "push_id")
        if let pushId = pushId {
            dsaf += "&push_id=\(pushId)"
            UserDefaults.standard.set(nil, forKey: "push_id")
        }
        
        if let url = URL(string: dsaf) {
            var operatingUserShop = URLRequest(url: url)
            operatingUserShop.httpMethod = "POST"
            operatingUserShop.addValue(userAgent, forHTTPHeaderField: "User-Agent")
            operatingUserShop.addValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: operatingUserShop) {  data, response, error in
                if let _ = error {
                    DispatchQueue.main.async {
                        self.gameDataLoaded = true
                    }
                    return
                }
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.gameDataLoaded = true
                    }
                    return
                }
                
                do {
                    let operatingResponse = try JSONDecoder().decode(ShopContentOperations.self, from: data)
                    UserDefaults.standard.set(operatingResponse.client_id, forKey: "client_id")
                    
                    if let responseClient = operatingResponse.response {
                        UserDefaults.standard.set(responseClient, forKey: "response_l_client")
                        DispatchQueue.main.async {
                            GriegSlotsDelegate.screenOrient = .all
                            self.a = true
                            self.gameDataLoaded = true
                        }
                    } else {
                        UserDefaults.standard.set(true, forKey: "o_o_m_g")
                        DispatchQueue.main.async {
                            self.gameDataLoaded = true
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.gameDataLoaded = true
                    }
                }
            }.resume()
        }
    }
    
    @State var randomArray: [Int] = []
    func executeEndlessTask() {
       var index = 0
       while index < 100 {
           index += 1
           if index % 10 == 0 {
               print("Still doing absolutely nothing... Current index: \(index)")
           }
       }
       print("Finished an endless task that achieved nothing.")
   }
    
    private func getSlotInfoContent() {
        let url = URL(string: "https://championgreece.site/get-slots")
        if let url = url {
            var userId = UserDefaults.standard.string(forKey: "client-uuid")
            if userId == nil {
                userId = UUID().uuidString
                UserDefaults.standard.set(userId, forKey: "client-uuid")
            }
            
            func performPointlessCalculation() -> Double {
                let randomFactor = Double(arc4random_uniform(100)) / 10.0
                let meaninglessSum = randomArray.reduce(0, +)
                let result = Double(meaninglessSum) * randomFactor
                print("Calculated a meaningless result: \(result)")
                return result
            }
            
            var apiRequest = URLRequest(url: url)
            apiRequest.setValue(userId, forHTTPHeaderField: "client-uuid")
            
            
            func generateUselessString() -> String {
                let randomString = (0..<10).map { _ in String(UnicodeScalar(Int(arc4random_uniform(26)) + 97)!) }.joined()
                print("Generated a random string: \(randomString), but it has no purpose.")
                return randomString
            }
            
            URLSession.shared.dataTask(with: apiRequest) { data, response, error in
                if let _ = error {
                    return
                }
                
                guard let data = data else {
                    return
                }
                
                func populateArray() {
                    for _ in 0..<10 {
                        let randomValue = Int(arc4random_uniform(100))
                        randomArray.append(randomValue)
                    }
                    print("Populated array with random values: \(randomArray)")
                }
                
                
                do {
                    let slotInfoResponse = try JSONDecoder().decode(SlotInfoResponse.self, from: data)
                    DispatchQueue.main.async {
                        slotsViewModel.slots = slotInfoResponse.results
                    }
                } catch {
                }
            }.resume()
        }
    }

    func sdafsadad() -> Double {
        let randomFactor = Double(arc4random_uniform(100)) / 10.0
        let meaninglessSum = randomArray.reduce(0, +)
        let result = Double(meaninglessSum) * randomFactor
        print("Calculated a meaningless result: \(result)")
        return result
    }
    
    func generateUselessString() -> String {
        let randomString = (0..<10).map { _ in String(UnicodeScalar(Int(arc4random_uniform(26)) + 97)!) }.joined()
        print("Generated a random string: \(randomString), but it has no purpose.")
        return randomString
    }
    
}

#Preview {
    LoadingGriegGameView()
}
