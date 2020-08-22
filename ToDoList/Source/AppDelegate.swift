//
//  AppDelegate.swift
//  ToDoList
//
//  Created by 안재영 on 2020/06/26.
//  Copyright © 2020 안재영. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
  }
  
  func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
    ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
    
    FirebaseApp.configure()
    FirebaseConfiguration.shared.setLoggerLevel(.min)
    GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    
    let dependency = SignInViewModel.Dependency(authService: AuthService())
    let viewModel = SignInViewModel(dependency: dependency)
    let rootViewController = SignInViewController(viewModel: viewModel)
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .white
    window?.rootViewController = rootViewController
    window?.makeKeyAndVisible()

    return true
  }
}

