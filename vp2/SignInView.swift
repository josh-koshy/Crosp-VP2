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
    @State var hasLoginFailed = false
    @State var isSignUp = false
    @State var failCount: Int = 0
    @State var attempts: Int = 0
    @State var uid = ""
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    
                    Picker("Flavor", selection: $isSignUp) {
                        Text("Sign In").tag(false)
                        Text("Sign Up").tag(true)
                    }.pickerStyle(.segmented)
                    
                    TextField("Email", text: $email).font(.title)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $password).font(.title)
                    Divider()
                    Button(action: {!isSignUp ? login() : SignUp() } ) {
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
                        Text("By Creating an Account, you agree with all Crosp Legal Terms.").font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                    }
                    if hasLoginFailed == true {
                        if !isSignUp {
                            Text("Incorrect Password, please try again.")
                                .foregroundColor(Color.red)
                                .frame(height: 4.0)
                            //   Animation() { self.attempts += 1 }
                            
                        }
                    }
                    // move to an authenticated screen
                    NavigationLink(destination: MainScreenView(uid: uid, email: ""), isActive: $isAuthed) { EmptyView() }
                    Spacer()
                }
                .padding()
                .navigationTitle(!isSignUp ? "Crosp Log-In" : "Crosp Sign-Up")
            }.ignoresSafeArea(.keyboard)
            
        }
    }
    
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
                self.hasLoginFailed = true
                withAnimation(.default) {
                    self.attempts += 1
                }
                errorHaptic()
            } else {
                mode.wrappedValue.dismiss()
            }
        }
    }
    
    func SignUp() {
        Auth.auth().createUser(withEmail: email, password: password) { ( authResult, error) in
           guard let user = authResult?.user, error == nil else {
               print(error!.localizedDescription)
               return
           }
            print("Success. UID is: " + user.uid)
            if let email = user.email {
                print("Email is: " + email)
            }
            
            mode.wrappedValue.dismiss()
        }
    }
    
} // END OF STRUCT!!!
            

struct MainScreenViewPreview: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
