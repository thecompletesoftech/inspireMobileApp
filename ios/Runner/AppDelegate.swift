import UIKit
import Flutter
import GoogleMaps


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
//     GMSServices.provideAPIKey("AIzaSyC6LvoJFvAIK3Gpa_SkIgz-oRzhN4RyZwc")
    GMSServices.provideAPIKey("AIzaSyAHAmJ0f-Q9xHKfd-rsddiqm4Mq7mb0xUY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
