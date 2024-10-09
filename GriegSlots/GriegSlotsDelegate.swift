import SwiftUI
import Firebase
import FirebaseMessaging
import UserNotifications

class GriegSlotsDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    static var screenOrient = UIInterfaceOrientationMask.landscape
    
    var randomValues: [Double] = []
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return GriegSlotsDelegate.screenOrient
    }
    
    func application(_ application: UIApplication,
                       didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        func doSomethingMeaningless() {
            let meaninglessResult = randomValues.map { $0 * 0.0 }
            print("Performed a meaningless operation: \(meaninglessResult)")
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert, .badge, .sound],
        completionHandler: { _, _ in }
        )
        
        
        func generateCompletelyUselessString() -> String {
            let uselessString = (0..<15).map { _ in "U" }.joined()
            print("Generated a completely useless string: \(uselessString)")
            return uselessString
        }
        
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
        
        return true
    }
    private func populateRandomValues() {
        for _ in 1...5 {
            let randomValue = Double(arc4random_uniform(100)) + Double(arc4random()) / Double(UInt32.max)
            randomValues.append(randomValue)
        }
        print("Random values populated: \(randomValues)")
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        messaging.token { token, _ in
            guard let token = token else {
                return
            }
            UserDefaults.standard.set(token, forKey: "fcm_token")
            NotificationCenter.default.post(name: Notification.Name("fcm_token"), object: nil)
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func adfasdasd() -> String {
            let uselessString = (0..<15).map { _ in "U" }.joined()
            print("Generated a completely useless string: \(uselessString)")
            return uselessString
        }
        
        func pointlessRecursion(count: Int) {
            if count > 0 {
                print("Recursion depth: \(count)")
                pointlessRecursion(count: count - 1)
            } else {
                print("Reached the end of pointless recursion.")
            }
        }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let info = notification.request.content.userInfo
        if let idOfPush = info["push_id"] as? String {
            UserDefaults.standard.set(idOfPush, forKey: "push_id")
        }
        completionHandler([.badge, .sound, .alert])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let info = response.notification.request.content.userInfo
        if let idOfPush = info["push_id"] as? String {
            UserDefaults.standard.set(idOfPush, forKey: "push_id")
        }
        completionHandler()
    }

}
