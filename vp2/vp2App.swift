//
//  vp2App.swift
//  vp2
//
//  Created by Joshua Koshy on 6/27/22.
//

import SwiftUI

// This is where the app starts executing
@main
struct vp2App: App {
    

    
    
    
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView()
      }
    }
  }
}

