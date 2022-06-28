//
//  ContentView.swift
//  vp2
//
//  Created by Joshua Koshy on 6/27/22.
//

import SwiftUI
import FirebaseCore

// Firebase boilerplate code
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

// SwiftUI code starts executing here:
struct HomeView: View {
    @State private var ShowHapticView = false
    @State private var ShowSignInView = false

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                
                Button{ softHaptic(); self.ShowSignInView = true } label: {
                    Text("Navigate to SignInView")
                }
                
                
                Divider()
                
                NavigationLink(destination: HapticView(), isActive: $ShowHapticView) { EmptyView() }
                NavigationLink(destination: SignInView(), isActive: $ShowSignInView) { EmptyView() }
                
                
                Button { softHaptic(); self.ShowHapticView = true } label: {
                    Text("Navigate to HapticView to Test Haptics.")
                }
                
                
            }
    }.navigationBarBackButtonHidden(true)
        
    }
}


struct VP2Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
