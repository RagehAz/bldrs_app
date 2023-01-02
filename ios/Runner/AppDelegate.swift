import UIKit
import Flutter
import Firebase
import FirebaseMessaging
// import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
        FirebaseApp.configure()
        // GMServices.provideAPIKey("AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI")
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
   }
}