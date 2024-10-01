import SwiftUI

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

#Preview {
    AppollonianSlotInfoGameView()
}
