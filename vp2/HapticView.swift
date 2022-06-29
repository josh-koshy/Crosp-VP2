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
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                let holdDuration: Double = 0.5
                NavigationLink(destination: HomeView(), isActive: $ShowView1) { EmptyView() }
                
                Button{
                    Check()
                } label: {
                    Text("Am I Authed?")
                }
                
                if cool != "" {
                    Divider()
                    Text("UID: \(cool)")
                    .font(.caption)
                    
                }
                
                
                Button { successHaptic() } label: { Text("Success") }
                    .simultaneousGesture(LongPressGesture(minimumDuration: holdDuration).onEnded{ _ in softHaptic() ; print("The button was held...") })
                
                
                
                Button { errorHaptic() } label: { Text("Error") }
                    .simultaneousGesture(LongPressGesture(minimumDuration: holdDuration).onEnded{ _ in softHaptic() ; print("The button was held...") })
                
                Button { warningHaptic() } label: { Text("Warning") }
                    .simultaneousGesture(LongPressGesture(minimumDuration: holdDuration).onEnded{ _ in softHaptic() ; print("The button was held...") })
                
                
                Divider()
                
                Button{ print("Press Recorded") } label: { Text("Hold to Go Back Bruh...") }
                    .simultaneousGesture(LongPressGesture(minimumDuration: holdDuration).onEnded{ _ in
                    softHaptic()
                    mode.wrappedValue.dismiss()
                    print("The button was held...")
                })
                
            } // end of VStack
        }.navigationBarBackButtonHidden(true) // end of NavigationView
    }
    
    func Check() {
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                self.cool = user.uid
            }
            
        }
    }
    
    }


struct SecondaryViewPreview: PreviewProvider {
    static var previews: some View {
        HapticView(cool: "")
    }
}
