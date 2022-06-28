//
//  SignInView.swift
//  vp2
//
//  Created by Joshua Koshy on 6/27/22.
//

import Foundation
import SwiftUI
import FirebaseAuth




struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var isAuthed = false
    @State var isFailed = false
    @State var failCount: Int = 0
    @State var attempts: Int = 0
    
    var body: some View {
        NavigationView{
            
            VStack(spacing: 30) {
                TextField("Email", text: $email).keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
                Divider()
            
                Button(action: { login() } ) {
                    HStack {
                        Text("Sign In").foregroundColor(Color.red)
                            .font(.title)
                            .bold()
                    }
                    .padding(.horizontal, 80)
                    .padding(.vertical, 20)
                    .background(Color.black)
                    .cornerRadius(10.0)
                    .modifier(Shake(animatableData: CGFloat(attempts)))
                }
                
                
                if isFailed == true {
                    Text("Incorrect Password, please try again.")
                        .foregroundColor(Color.red)
                        .frame(height: 4.0)
                 //   Animation() { self.attempts += 1 }
                }
                else {
                    NavigationLink(destination: Text("Success Buddy, you're in."), isActive: $isAuthed) { EmptyView() }
                }
                
            }
            .padding()
        }
    }
    
    func login() {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.isFailed = true
                    self.failCount += 1
                    withAnimation(.default) {
                        self.attempts += 1
                    }
                    errorHaptic()
                } else {
                    print("success")
                    self.isAuthed = true
                }
            }
        }
}


struct SignInViewPreview: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}


