//
//  SecondaryView.swift
//  vp2
//
//  Created by Joshua Koshy on 6/27/22.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct HapticView : View {
    @State var cool: String
    @State private var ShowView1 = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var SignMeIn = false
    @State var PressedSignMeInCount:Int = 0
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                let holdDuration: Double = 0.5
                NavigationLink(destination: HomeView(), isActive: $ShowView1) { EmptyView() }
                
                Button{
                    Check()
                    if cool == "" {
                        self.SignMeIn = true
                    }
                    else {
                        withAnimation(.default) {
                            self.PressedSignMeInCount += 1
                        errorHaptic()
                        }
                    }
                    
                } label: {
                    Text("Am I Authed?")
                }
                
                if cool != "" {
                    Divider()
                    VStack{
                        Text("You are authenticated.")
                        Text("UID: \(cool)")
                            
                    }.font(.caption).modifier(Shake(animatableData: CGFloat(PressedSignMeInCount)))
                    
                    
                } else {
                    Divider()
                    Text("You are not signed in.")
                    .font(.caption)
                    
                }
                
                Button { successHaptic() } label: { Text("Hold to Log Out") }
                    .simultaneousGesture(LongPressGesture(minimumDuration: holdDuration).onEnded{ _ in softHaptic() ; SignOut() ; Check() })
                
                
                Divider()
                
                NavigationLink(destination: SignInView(), isActive: $SignMeIn) { EmptyView() }
                
                Button{ print("Press Recorded") } label: { Text("Hold to Go Back Bruh...") }
                    .simultaneousGesture(LongPressGesture(minimumDuration: holdDuration).onEnded{ _ in
                    softHaptic()
                    mode.wrappedValue.dismiss()
                        
                })
                
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
                self.cool = user.uid
            }
        }
        else {
            self.cool = ""
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
        HapticView(cool: "")
    }
}
