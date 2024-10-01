import SwiftUI

struct GameOptionsView: View {
    
    @Environment(\.presentationMode) var presMode
    
    @State var volumeOfMusic = UserDefaults.standard.integer(forKey: "volume_music")
    @State var volumeOfSounds = UserDefaults.standard.integer(forKey: "volume_sounds")
    
    var body: some View {
        VStack {
            Text("OPTIONS")
                .font(.custom("RammettoOne-Regular", size: 52))
                .foregroundColor(Color.init(red: 237/255, green: 77/255, blue: 248/255))
                .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: 1, y: 0)
                .shadow(color: Color.init(red: 251/255, green: 214/255, blue: 102/255), radius: 2, x: -1, y: 0)
            
            Spacer()
            
            HStack {
                Image("ic_music")
                    .resizable()
                    .frame(width: 72, height: 102)
                
                Button {
                    withAnimation(.linear) {
                        if volumeOfMusic == 1 {
                            volumeOfMusic = 0
                        } else {
                            volumeOfMusic = 1
                        }
                    }
                } label: {
                    if volumeOfMusic == 1 {
                        Image("volume_on")
                            .resizable()
                            .frame(width: 200, height: 30)
                    } else {
                        Image("volume_off")
                            .resizable()
                            .frame(width: 200, height: 30)
                    }
                }
            }
            
            HStack {
                Image("ic_sound")
                    .resizable()
                    .frame(width: 72, height: 102)
                
                Button {
                    withAnimation(.linear) {
                        if volumeOfSounds == 1 {
                            volumeOfSounds = 0
                        } else {
                            volumeOfSounds = 1
                        }
                    }
                } label: {
                    if volumeOfSounds == 1 {
                        Image("volume_on")
                            .resizable()
                            .frame(width: 200, height: 30)
                    } else {
                        Image("volume_off")
                            .resizable()
                            .frame(width: 200, height: 30)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Button {
                    presMode.wrappedValue.dismiss()
                } label: {
                    Image("home")
                        .resizable()
                        .frame(width: 62, height: 82)
                }
                Spacer()
            }
        }
        .onChange(of: volumeOfMusic) { newValue in
            UserDefaults.standard.set(newValue, forKey: "volume_music")
        }
        .onChange(of: volumeOfSounds) { newValue in
            UserDefaults.standard.set(newValue, forKey: "volume_sounds")
        }
        .background(
            Image("slot_chooser_bg")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    GameOptionsView()
}
