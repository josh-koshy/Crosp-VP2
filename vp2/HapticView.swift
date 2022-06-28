//
//  SecondaryView.swift
//  vp2
//
//  Created by Joshua Koshy on 6/27/22.
//

import Foundation
import SwiftUI

struct HapticView : View {
    @State private var ShowView1 = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        
        NavigationView {
            VStack(spacing: 30) {
                let holdDuration: Double = 0.5
                NavigationLink(destination: HomeView(), isActive: $ShowView1) { EmptyView() }
                
                
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
    
    }


struct SecondaryViewPreview: PreviewProvider {
    static var previews: some View {
        HapticView()
    }
}
