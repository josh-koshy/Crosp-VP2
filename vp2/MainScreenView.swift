//
//  SecondaryView.swift
//  vp2
//
//  Created by Joshua Koshy on 6/27/22.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth


//Firebase Boilerplate Code
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


struct OverlayContainer {
    static var isAuthed: Bool = false
}


struct MainScreenView : View {
    @State var uid: String
    @State var email: String
    @State private var ShowView1 = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var SignMeIn = false
    @State var PressedSignMeInCount:Int = 0
    @State var ShouldICheckForAuthState = false
    
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                let holdDuration: Double = 0.5
//                NavigationLink(destination: HomeView(), isActive: $ShowView1) { EmptyView() }
                
                Button{
                    Check()
                    if uid == "" {
                        self.SignMeIn = true
                    }
                    else {
                        withAnimation(.default) {
                            self.PressedSignMeInCount += 1
                        }
                        errorHaptic()
                    }
                    
                } label: {
                    Text("Sign-In Page ->").font(.title2).foregroundStyle(.linearGradient(colors: [.red, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                }
                
                if uid != "" {
                    Divider()
                    VStack{
                        Text("You are authenticated.")
                        Text("UID: \(uid)")
                        Text("Email: \(self.email)")
                            
                    }.font(.caption)
                    
                    
                }
                
                if uid != "" {
                    Button { } label: { Text("Hold to Log Out") }
                        .modifier(Shake(animatableData: CGFloat(PressedSignMeInCount)))
                        .simultaneousGesture(LongPressGesture(minimumDuration: holdDuration).onEnded{ _ in softHaptic() ; SignOut() ; Check() })
                }
                
                
                NavigationLink(destination: SignInView(), isActive: $SignMeIn) { EmptyView() }
                
                
            } // end of VStack
            
        }.navigationBarBackButtonHidden(true)
            .onAppear{
                Check()
            }
        // end of NavigationView
    }
    
    func Check() {
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                self.uid = user.uid
                if let email = user.email {
                    self.email = email
                } else {
                    print("Missing name.")
                }
            }
        }
        else {
            self.uid = ""
        }
    }
}

func SignOut() {
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
}


struct SecondaryViewPreview: PreviewProvider {
    static var previews: some View {
        MainScreenView(uid: "", email: "")
    }
}
