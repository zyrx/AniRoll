//
//  LoginPage.swift
//  AniRoll
//
//  Created by Lech H. Conde on 10/11/23.
//  Copyright © 2023 mavels.net. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - LoginPage

class LoginPage: UIHostingController<LoginView> {
    
    init() {
        super.init(rootView: LoginView())
    }
    
    @available(*, unavailable)
    required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - LoginView

struct LoginView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Color("primary")
                .overlay {
                    Image("ar_background_1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.15)
                        .ignoresSafeArea()
                }
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Image("ar_full_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom, 24)
                
                TextField(text: $username, prompt: Text("Username")) {
                    Text("Username")
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                SecureField(text: $password, prompt: Text("Password")) {
                    Text("Password")
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Button(action: {}, label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                })
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .textFieldStyle(.roundedBorder)
            .padding(24)
        }
        
    }
}

// MARK: - LoginView_Previews


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
