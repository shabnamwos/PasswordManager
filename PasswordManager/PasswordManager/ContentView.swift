//
//  ContentView.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI
import LocalAuthentication


struct ContentView: View {
    var size: CGSize
    let persistenceController = PersistenceController.shared

    
    @State private var isFaceIdDone: Bool = false
    var body: some View {
        NavigationStack{
            VStack(
                alignment: .center,
                spacing: 10
            ){
                Text(isFaceIdDone ? "Face ID worked!!" : "Hello, Gigs")
                    .onAppear{
                        print("here")
                        Task.detached{ @MainActor in
                            print("will start on appear main")
                            faceIdAuthentication()
                        }
                    }
                Button{
                    isFaceIdDone = false
                    faceIdAuthentication()
                    
                } label: {
                    Text("Reset")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: size.width * 0.4)
                        .padding(.vertical, 15)
                        .background{
                            Capsule()
                                .fill(.black)
                        }
                }
                .navigationDestination(isPresented: $isFaceIdDone) {
                      HomeView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)

                        .navigationBarBackButtonHidden()
                  }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .frame(maxHeight: .infinity, alignment: .center)
        }
    }
    
    func faceIdAuthentication(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "Authenticate to access the app"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                if success{
                    print("successed")
                    isFaceIdDone = true
                }else{
                    print("failed")
                }
            }
        }else{
            // Device does not support Face ID or Touch ID
            print("Biometric authentication unavailable")
        }
    }
}

#Preview {
    ContentView(size: CGSize(width: 120.0, height: 120.0))
}


