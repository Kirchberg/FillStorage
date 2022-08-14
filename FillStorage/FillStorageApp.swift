//
//  FillStorageApp.swift
//  FillStorage
//
//  Created by Kirill Kostarev on 14.08.2022.
//

import UIKit
import SwiftUI

@main
struct MainApp {

    static func main() {
        if #available(iOS 14.0, *) {
            FillStorageApp.main()
        } else {
            UIApplicationMain(
                CommandLine.argc,
                CommandLine.unsafeArgv,
                nil,
                NSStringFromClass(AppDelegate.self)
            )
        }
    }

}

@available(iOS 14.0, *)
struct FillStorageApp: App {

    var body: some Scene {
        WindowGroup {
            DebugPanelFillStorageViewFactory().makeView()
        }
    }

}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
            window?.rootViewController = DebugPanelFillStorageViewFactory().makeViewController()
            window?.makeKeyAndVisible()
        }
    }

}
