import SwiftUI

class SlotsViewModel: ObservableObject {
    @Published var slots: [SlotInfoItem] = []
}

struct ContentView: View {
    
    @EnvironmentObject var slotViewModel: SlotsViewModel
    @StateObject var slotsStarsManager = SlotsAchivementsManager()
    @StateObject var userConfig = UserConfig()
    @State private var selectedItem: Int = 0
    
    var slots = [
        "slot_hera",
        "pinko_ball",
        "slot_apollonian",
        "slot_sweet_rome"
    ]
    @State var selectedSlot = "HERA"
    
    @State var showInfoAboutCanPlaySlot = false
    @State var passToGame = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        ZStack {
                            Image("balance_background")
                                .resizable()
                                .frame(width: 120, height: 50)
                        }
                        .opacity(0)
                        Spacer()
                        
                        Text("\(selectedSlot)")
                            .font(.custom("RammettoOne-Regular", size: 52))
                            .foregroundColor(Color.init(red: 237/255, green: 77/255, blue: 248/255))
                            .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: 1, y: 0)
                            .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: -1, y: 0)
                        
                        Spacer()
                        
                        ZStack {
                            Image("balance_background")
                                .resizable()
                                .frame(width: 120, height: 50)
                                
                            Text("\(userConfig.coins)")     .font(.custom("RammettoOne-Regular", size: 26))
                                .foregroundColor(Color.init(red: 230/255, green: 184/255, blue: 69/255))
                                .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: 1, y: 0)
                                .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: -1, y: 0)
                        }
                    }
                    Spacer()
                    
                    SliderView(selectedItem: $selectedItem, items: slots)
                        .environmentObject(slotsStarsManager)
                    
                    Spacer()
                    
                    HStack {
//                        NavigationLink(destination: EmptyView()) {
//                            Image("shop")
//                                .resizable()
//                                .frame(width: 62, height: 82)
//                        }
                        NavigationLink(destination: SpinGameView()
                            .environmentObject(userConfig)
                            .navigationBarBackButtonHidden()) {
                            Image("spin")
                                .resizable()
                                .frame(width: 62, height: 82)
                        }
                        .padding(.leading)
                        Spacer()
                        
                        Button {
                            if selectedItem == 2 {
                                let prevSlotName = slots[selectedItem - 1]
                                if slotsStarsManager.starsForGames[prevSlotName]! == 5 {
                                    passToGame = true
                                } else {
                                    withAnimation(.easeIn) {
                                        showInfoAboutCanPlaySlot = true
                                    }
                                }
                            } else {
                                passToGame = true
                            }
                        } label: {
                            Image("play_btn")
                                .resizable()
                                .frame(width: 180, height: 90)
                        }
                        Spacer()
                        
                        NavigationLink(destination: GameChooserByName(name: selectedSlot)
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(userConfig)
                            .environmentObject(slotsStarsManager), isActive: $passToGame) {
                            
                        }
                        
//                        Image("option")
//                            .resizable()
//                            .frame(width: 62, height: 82)
//                            .opacity(0)
                        
                        NavigationLink(destination: GameOptionsView()
                            .navigationBarBackButtonHidden()) {
                            Image("option")
                                .resizable()
                                .frame(width: 62, height: 82)
                        }
                    }
                }
                .onChange(of: selectedItem) { newValue in
                    withAnimation(.bouncy) {
                        if newValue == 0 {
                            selectedSlot = "HERA"
                        } else if newValue == 1 {
                            selectedSlot = "PINKO BALL"
                        } else if newValue == 2 {
                            selectedSlot = "APPOLLINIAN"
                        } else if newValue == 3 {
                            selectedSlot = "SWEET ROME"
                        }
                    }
                }
                
                if showInfoAboutCanPlaySlot {
                    ZStack {
                        VStack {
                            Spacer()
                            
                            Text("\(selectedSlot)")
                                .font(.custom("RammettoOne-Regular", size: 52))
                                .foregroundColor(Color.init(red: 237/255, green: 77/255, blue: 248/255))
                                .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: 1, y: 0)
                                .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: -1, y: 0)
                            
                            Spacer()
                            
                            Image(slots[selectedItem])
                                .resizable()
                                .frame(width: 170, height: 150)
                            
                            Spacer()
                            
                            Text("Collect 5 stars on the previous\none to unlock the level!")     .font(.custom("RammettoOne-Regular", size: 20))
                                .foregroundColor(Color.init(red: 230/255, green: 184/255, blue: 69/255))
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                                Button {
                                    withAnimation(.easeOut) {
                                        showInfoAboutCanPlaySlot = false
                                    }
                                } label: {
                                    Image("close_button")
                                        .resizable()
                                        .frame(width: 52, height: 68)
                                }
                            }
                            .padding([.top, .trailing], 42)
                            Spacer()
                        }
                    }
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height + 20)
                    .background(
                        Rectangle()
                            .fill(.white.opacity(0.15))
                            .background(
                                VisualEffectBlur(effect: .dark)
                            )
                            .cornerRadius(10)
                    )
                }
            }
            .background(
                Image("slot_chooser_bg")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height + 20)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
        .environmentObject(SlotsViewModel())
}

struct SliderView: View {
    @Binding var selectedItem: Int
    var items: [String]
    @EnvironmentObject var slotsRang: SlotsAchivementsManager
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(Array(items.enumerated()), id: \.element) { index, item in
                        GeometryReader { itemGeometry in
                            SliderItemView(item: item)
                                .environmentObject(slotsRang)
                                .frame(width: geometry.size.width * 0.6) // Ширина элемента составляет 60% от ширины экрана
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .onAppear {
                                    updateSelectedItem(for: itemGeometry, in: geometry.size, index: index)
                                }
                                .onChange(of: itemGeometry.frame(in: .global).minX) { _ in
                                    updateSelectedItem(for: itemGeometry, in: geometry.size, index: index)
                                }
                        }
                        .frame(width: geometry.size.width * 0.6) // Задание ширины кадра для каждого элемента
                    }
                }
                .padding(.horizontal, (geometry.size.width * 0.2)) // Центрирование элементов
            }
        }
    }
    
    // Определение текущего выбранного элемента
    private func updateSelectedItem(for itemGeometry: GeometryProxy, in containerSize: CGSize, index: Int) {
        let midX = itemGeometry.frame(in: .global).midX
        let centerX = containerSize.width / 2
        
        // Проверяем, ближе ли центр элемента к центру экрана
        if abs(midX - centerX) < containerSize.width * 0.3 { // Задаем допуск для выбора элемента
            selectedItem = index
        }
    }
}

struct SliderItemView: View {
    var item: String
    @EnvironmentObject var slotsRang: SlotsAchivementsManager
    
    var body: some View {
        VStack(spacing: 0) {
            Image(item)
                .resizable()
                .frame(width: 170, height: 150)
            
            HStack {
                ForEach(1...5, id: \.self) { index in
                    if slotsRang.starsForGames[item]! >= index {
                        Image("star_on")
                            .resizable()
                            .frame(width: 28, height: 28)
                    } else {
                        Image("star_off")
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                }
            }
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var effect: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: effect))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: effect)
    }
}
