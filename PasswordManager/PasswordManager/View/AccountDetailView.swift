//
//  AccountDetailView.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI

struct AccountDetailView: View {
    
    //MARK: - variable
     //var password: PasswordTable
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: PasswordViewModel
    @Binding var editableItem: PasswordTable?
    
    @State private var isSecured: Bool = true
    @State private var showingAlert = false
    @State var decryptedPassword = ""
    @Binding var isEdit : Bool
    
    //MARK: - view
    var body: some View {
        ZStack{
            Color.backgroundColor
            VStack(alignment: .leading) {
                viewHeader
                .padding(.bottom, 20)
                
                viewAccountType
                .padding(.bottom, 15)
                
                viewUsername
                .padding(.bottom, 15)
                
                viewPassword
                .padding(.bottom, 25)
                
                viewButton
            }.padding()
        }
        .ignoresSafeArea(.all)
        .onAppear{
            do {
                let password = editableItem?.password ?? ""
                decryptedPassword = try password.aesDecrypt()
            } catch {
                print("Decryption error: \(error)")
                decryptedPassword =  "Error"
            }
        }
        
    }
    
    private var viewHeader : some View{
        Text("Account Details")
            .setFont(.blueColor, .poppinsBold, 23)
    }
    
    private var viewAccountType : some View{
        VStack(alignment: .leading){
            Text("Account Type")
                .setFont(.subtitleColor, .roboto, 15)
            
            Text(editableItem?.accountName ?? "")
                .setFont(.titleColor, .poppinsSemiBold, 17)
        }
    }
    
    private var viewUsername : some View{
        VStack(alignment: .leading){
            Text("Username/Email")
                .setFont(.subtitleColor, .roboto, 15)
            
            Text(verbatim: editableItem?.email ?? "")
                .setFont(.titleColor, .poppinsSemiBold, 17)
        }
    }
    
    private var viewPassword : some View{
        VStack(alignment: .leading){
            Text("Password")
                .setFont(.subtitleColor, .roboto, 15)
            
            HStack {
                if isSecured{
                    SecureField("Password", text: .constant("*******"))
                        .setFont(.titleColor, .poppinsSemiBold, 17)
                }else{
                    Text(decryptedPassword)
                    .setFont(.titleColor, .poppinsSemiBold, 17)
                }
                
                Spacer()
                
                Button(action: {
                    isSecured.toggle()
                }, label: {
                    Image( isSecured ? "eye-close" : "eye-open")
                        .foregroundColor(.gray)
                })
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    private var viewButton : some View{
        HStack(spacing: 20){
            
            Button(action: {
                isEdit.toggle()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                NavigationLink(destination: EmptyView(), label: {
                   ButtonView(label: "Edit", action: {})
                })
            })
            
            
            ButtonView(label: "Delete", background: Color.negativeButtonColor, action: {
                showingAlert = true
            })
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Confirm Deletion"),
                    message: Text("Are you sure you want to delete this item?"),
                    primaryButton: .destructive(Text("Delete")) {
                        delete()
                    },
                    secondaryButton: .cancel()
                )
            }

        }
    }
    
    //MARK: - function
    
    func delete(){
        viewModel.deleteItem(editableItem!)
        presentationMode.wrappedValue.dismiss()
    }
    
}
