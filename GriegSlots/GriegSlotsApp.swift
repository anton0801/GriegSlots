import SwiftUI

@main
struct GriegSlotsApp: App {
    
    @UIApplicationDelegateAdaptor(GriegSlotsDelegate.self) var delegateOfGriegApp
    
    var body: some Scene {
        WindowGroup {
            LoadingGriegGameView()
        }
    }
}
