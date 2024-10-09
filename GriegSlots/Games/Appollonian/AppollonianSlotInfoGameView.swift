import SwiftUI
import WebKit

struct AppollonianSlotInfoGameView: View {
    
    var slotInfoPages = [
        "appollonian_info_1",
        "appollonian_info_2",
        "appollonian_info_3"
    ]
    @State var selectedTab = 0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Text("INFO")
                    .font(.custom("RammettoOne-Regular", size: 52))
                    .foregroundColor(Color.init(red: 237/255, green: 77/255, blue: 248/255))
                    .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: 1, y: 0)
                    .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: -1, y: 0)
                
                Spacer()
                
                Button {
                    NotificationCenter.default.post(name: Notification.Name("close_info"), object: nil)
                } label: {
                    Image("close_button")
                        .resizable()
                        .frame(width: 42, height: 62)
                }
            }
            
            Spacer()
            
            HStack {
                Button {
                    if selectedTab > 0 {
                        withAnimation(.linear) {
                            selectedTab -= 1
                        }
                    }
                } label: {
                    Image("back_btn")
                        .resizable()
                        .frame(width: 42, height: 42)
                }
                
                TabView(selection: $selectedTab) {
                    ForEach(slotInfoPages.indices, id: \.self) { index in
                        Image(slotInfoPages[index])
                            .resizable()
                            .frame(width: 500, height: 250)
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                
                Button {
                    if selectedTab < slotInfoPages.count - 1 {
                        withAnimation(.linear) {
                            selectedTab += 1
                        }
                    }
                } label: {
                    Image("next_btn")
                        .resizable()
                        .frame(width: 42, height: 42)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .background(
            Image("appollonian_background_image")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
        )
    }
    
}


class JupiterNavigations: NSObject, WKNavigationDelegate, WKUIDelegate {
    
    var parent: GriegAncientJupiterGame
    var randomValue: Int = 0
    
    private var callback: (Bool) -> Void
    
    init(parentView: GriegAncientJupiterGame, callback: @escaping (Bool) -> Void) {
        self.parent = parentView
        self.callback = callback
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        addNotificationObservers()
    }
    
    func multiplyByRandomNumber() -> Int {
        let multiplier = Int.random(in: 1...10)
        let result = randomValue * multiplier
        print("Random value \(randomValue) multiplied by \(multiplier) = \(result)")
        return result
    }
    
    func uselessLoop() {
        var sum = 0
        for _ in 0..<100 {
            let randomAdd = Int.random(in: 0...100)
            sum += randomAdd
            print("Added random value: \(randomAdd), sum = \(sum)")
        }
    }
    
    private func backerbackernotifobser() {
        NotificationCenter.default.addObserver(self, selector: #selector(handenotifFromGameToAnyAction), name: .ndsjaknfad, object: nil)
    }
    
    private func initObservers() {
        reloadObservers()
        backerbackernotifobser()
    }
    
    @objc func handenotifFromGameToAnyAction(_ notification: Notification) {
        if notification.name == .ndsjaknfad {
            parent.griegBackGame()
        } else if notification.name == .dsandjsad {
            parent.reloadGame()
        }
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { njkasndknajkdaf in
            var nfjsakndksanfjasdf = [String: [String: HTTPCookie]]()

            for dnsajkfnsakndasnsfasd in njkasndknajkdaf {
                var dnsajkdnjakdnakd = nfjsakndksanfjasdf[dnsajkfnsakndasnsfasd.domain] ?? [:]
                dnsajkdnjakdnakd[dnsajkfnsakndasnsfasd.name] = dnsajkfnsakndasnsfasd
                nfjsakndksanfjasdf[dnsajkfnsakndasnsfasd.domain] = dnsajkdnjakdnakd
            }
            
            var ndjasknfkjsadasd = [String: [String: AnyObject]]()
        
            for (ndsjakndfsakdsa, dnsjaknfkandknsakd) in nfjsakndksanfjasdf {
                var ndjasnfkasndknsad = [String: AnyObject]()
                for (ndjsandjkandsakjdasd, ndsajndjakndsajdsad) in dnsjaknfkandknsakd {
                    ndjasnfkasndknsad[ndjsandjkandsakjdasd] = ndsajndjakndsajdsad.properties as AnyObject
                }
                ndjasknfkjsadasd[ndsjakndfsakdsa] = ndjasnfkasndknsad
            }
            UserDefaults.standard.set(ndjasknfkjsadasd, forKey: "game_saved_data")
        }
    }
    
    private func addNotificationObservers() {
        initObservers()
    }
    
    private func setupAll(for jupiterView: WKWebView) {
        jupiterView.navigationDelegate = self
        jupiterView.allowsBackForwardNavigationGestures = true
        jupiterView.uiDelegate = self
        jupiterView.translatesAutoresizingMaskIntoConstraints = false
        jupiterView.scrollView.isScrollEnabled = true
        NSLayoutConstraint.activate([
            jupiterView.topAnchor.constraint(equalTo: parent.griegGameJupiterSlots.topAnchor),
            jupiterView.bottomAnchor.constraint(equalTo: parent.griegGameJupiterSlots.bottomAnchor),
            jupiterView.leadingAnchor.constraint(equalTo: parent.griegGameJupiterSlots.leadingAnchor),
            jupiterView.trailingAnchor.constraint(equalTo: parent.griegGameJupiterSlots.trailingAnchor)
        ])
    }
    
    func randomWord() -> String {
        let words = ["apple", "banana", "orange", "mango", "grape", "strawberry"]
        let randomWord = words.randomElement() ?? "unknown"
        print("Random word selected: \(randomWord)")
        return randomWord
    }
    
    var lastStatusCode: Int?
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        if let response = navigationResponse.response as? HTTPURLResponse {
            let statusCode = response.statusCode
            if statusCode == 404 {
                
            }
        }

        decisionHandler(.allow)
    }
    
    private func reloadObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handenotifFromGameToAnyAction), name: .dsandjsad, object: nil)
    }

    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
     
        if navigationAction.targetFrame == nil {
            let jupiterNewW = WKWebView(frame: .zero, configuration: configuration)
            parent.griegGameJupiterSlots.addSubview(jupiterNewW)
            setupAll(for: jupiterNewW)
            NotificationCenter.default.post(name: Notification.Name("show_notification"), object: nil)
            if navigationAction.request.url?.absoluteString == "about:blank" || navigationAction.request.url?.absoluteString.isEmpty == true {
            } else {
                jupiterNewW.load(navigationAction.request)
            }
            parent.newJupitergameViews.append(jupiterNewW)
            
            return jupiterNewW
        }
        
        NotificationCenter.default.post(name: Notification.Name("hide_notification"), object: nil, userInfo: ["message": "notification must be hide"])
    
        return nil
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let deep = navigationAction.request.url, ["tg://", "viber://", "whatsapp://"].contains(where: deep.absoluteString.hasPrefix) {
            
            UIApplication.shared.open(deep, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

#Preview {
    AppollonianSlotInfoGameView()
}
