//
//  ContentView.swift
//  vp2
//
//  Created by Joshua Koshy on 6/27/22.
//

//import SwiftUI
//import FirebaseCore
//
//
//// SwiftUI code starts executing here:
//struct HomeView: View {
//    @State private var ShowHapticView = false
//    @State private var ShowSignInView = false
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 30) {
//
//
//                Button{ softHaptic(); self.ShowSignInView = true } label: {
//                    Text("Navigate to SignInView")
//                }
//
//
//                Divider()
//
//                NavigationLink(destination: HapticView(uid: "", email: ""), isActive: $ShowHapticView) { EmptyView() }
//                NavigationLink(destination: SignInView(), isActive: $ShowSignInView) { EmptyView() }
//
//
//                Button { softHaptic(); self.ShowHapticView = true } label: {
//                    Text("Navigate to HapticView to Test Haptics.")
//                }
//
//
//            }
//    }.navigationBarBackButtonHidden(true)
//
//    }
//}
//
//
//struct VP2Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}

