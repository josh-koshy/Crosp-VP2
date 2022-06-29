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
    @State var isSignUp = false
    @State var failCount: Int = 0
    @State var attempts: Int = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    
                    Picker("Flavor", selection: $isSignUp) {
                        Text("Sign In").tag(false)
                        Text("Sign Up").tag(true)
                    }.pickerStyle(.segmented)
                    
                    TextField("Email", text: $email).keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password)
                    Divider()
                    
                    Button(action: {!isSignUp ? login() : mode.wrappedValue.dismiss()
                        
                    } ) {
                        HStack {
                            !isSignUp ? Text("Sign In").foregroundColor(Color.red).font(.title).bold() :
                            Text("Sign Up").foregroundColor(Color.red).font(.title).bold()
                        }
                        .padding(.horizontal, 80)
                        .padding(.vertical, 20)
                        .background(Color.black)
                        .cornerRadius(10.0)
                        .modifier(Shake(animatableData: CGFloat(attempts)))
                    }
                    if isSignUp == true {
                        Text("By Creating an Account, you agree with all Crosp Legal Terms. In this version of the app, Sign Up will not work. This is intentional: pressing Sign-Up will send you back.").font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                    }
                    if isFailed == true {
                        if !isSignUp {
                            Text("Incorrect Password, please try again.")
                                .foregroundColor(Color.red)
                                .frame(height: 4.0)
                            //   Animation() { self.attempts += 1 }
                        }
                    }
                    // move to an authenticated screen
                    NavigationLink(destination: HapticView(), isActive: $isAuthed) { EmptyView() }
                    Spacer()
                }
                .padding()
                .navigationTitle(!isSignUp ? "Crosp Log-In" : "Crosp Sign-Up")
            }.ignoresSafeArea(.keyboard)

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

    
    
    struct SignInViewPreview: PreviewProvider {
        static var previews: some View {
            SignInView()
        }
    }
}
