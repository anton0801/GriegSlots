import SwiftUI

class GriegOldStyleViewModels: ObservableObject {
    @Published var navVisible = false
    @Published var loaded = false
    @Published var loadedSuccess = false
}

struct MainHomeView: View {
    @StateObject var vm: GriegOldStyleViewModels = GriegOldStyleViewModels()
   @State var loadedContent = false
   
    struct JupiterNavigation: View {
G
        var body: some View {
            ZStack {
                Color.black
                HStack {
                    
                  Button {
                      NotificationCenter.default.post(name: .ndsjaknfad, object: nil)
                  } label: {
                      Image(systemName: "arrow.left")
                          .resizable()
                          .frame(width: 24, height: 24)
                          .foregroundColor(.blue)
                  }
                  
                    
                  Spacer()
                  
                  Button {
                      NotificationCenter.default.post(name: .dsandjsad, object: nil)
                  } label: {
                      Image(systemName: "arrow.clockwise")
                          .resizable()
                          .frame(width: 24, height: 24)
                          .foregroundColor(.blue)
                  }
              }
                .padding(6)
            }
            .frame(height: 60)
        }
        
    }

    
   var body: some View {
       NavigationView {
           ZStack {
               VStack {
                   GriegAncientJupiterGame(jupiterDeep: URL(string: UserDefaults.standard.string(forKey: "response_l_client") ?? "")!) { st in
                        vm.loadedSuccess = st
                        vm.loaded = true
                   }
                  if vm.navVisible {
                     JupiterNavigation()
                  }
               }
           }
           .onAppear {
               GriegSlotsDelegate.screenOrient = .all
           }
           .edgesIgnoringSafeArea([.trailing,.leading])
           .onReceive(NotificationCenter.default.publisher(for: Notification.Name("hide_notification")), perform: { _ in
               withAnimation(.linear(duration: 0.4)) {
                   vm.navVisible = false
               }
           })
           .preferredColorScheme(.dark)
           .onReceive(NotificationCenter.default.publisher(for: Notification.Name("show_notification")), perform: { _ in
               withAnimation(.linear(duration: 0.4)) {
                   vm.navVisible = true
               }
           })
       }
       .navigationViewStyle(StackNavigationViewStyle())
   }
}

#Preview {
    MainHomeView()
}
