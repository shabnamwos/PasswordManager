//
//  AddEditAccountView.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI
import PassGuard
import AlertToast


struct AddEditAccountView: View {
    
    //MARK: - variable
    @ObservedObject var viewModel: PasswordViewModel
    @Binding var editableItem: PasswordTable?
    @Environment(\.presentationMode) var presentationMode
    @State private var txtName: String = ""
    @State private var txtEmail: String = ""
    @State private var txtPassword: String = ""

    
    @State private var showToast = false
    @State private var showToastMsg : validationMsg?
    
    @State var strengthState: String = ""
    @State var btnTitle: String = "Add New Account"
    @State var strengthColor: Color = .clear
    @State var strengthScore: Float = 0.0
    
    
    //MARK: - view
    var body: some View {
        ZStack{
            Color.backgroundColor
            Form{
                textviewName
                textviewEmail
                textviewPassword
                buttonAction
            }
            .toast(isPresenting: $showToast){
                AlertToast(type:.regular  , title: showToastMsg?.rawValue)
            }
        }
        .onAppear{
            if editableItem != nil{
                
                do {
                    let password = editableItem?.password ?? ""
                    txtPassword = try password.aesDecrypt()
                } catch {
                    print("Decryption error: \(error)")
                    txtPassword =  editableItem?.password ?? ""
                }
                
                btnTitle = "Edit Account"
                txtName = editableItem?.accountName ?? ""
                txtEmail = editableItem?.email ?? ""
                strengthColor = .green
                strengthScore = 100.0
                strengthState = "Very Strong"
            }
        }
        .ignoresSafeArea(edges: .all)
    }
    
    private var textviewName: some View{
        TextFieldView(placeholder: "Account Name", text: $txtName)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
    }
    
    private var textviewEmail: some View{
        TextFieldView(placeholder: "Username/Email", text: $txtEmail)
        .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
    }
    
    
    private var textviewPassword: some View{
        
        VStack{
            SecureField("Password", text: $txtPassword)
                .setFont(.titleColor, .roboto, 16)
                .padding()
                .background(Color.whiteColor)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.subtitleColor, lineWidth: 0.5)
                )
                .onChange(of: txtPassword) { oldText, newText in
                    let passGuard = PassGuard(password: newText)
                    self.strengthState = passGuard.strengthDescription
                    self.strengthColor = Color(passGuard.strengthColor)
                    self.strengthScore = Float(passGuard.strengthScore)
                    debugPrint("strengthScore - \(strengthScore)")
                    
                }
            if !txtPassword.isEmpty{
                HStack{
                    Spacer()
                    Text(strengthState)
                        .setFont(.black, .sfProMedium, 16)
                        .foregroundColor(.black)
                }
                .padding(.top, 4)
                
                ProgressView("", value: strengthScore, total: 100)
                    .tint(strengthColor)
            }
            
        }
        .listRowSeparator(.hidden)
        .padding(.bottom, 10)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
    }
    
    private var buttonAction: some View{
        ButtonView(label: btnTitle , action: {
                        
            if txtName.isEmpty || txtName.count == 0{
                showToast.toggle()
                showToastMsg = .invalidAccountName
            }
            else if !txtEmail.isValidEmail(){
                showToast.toggle()
                showToastMsg = .invalidUserEmail
            }
            else if strengthScore != 100.0{
                showToast.toggle()
                showToastMsg = .invalidPassword
            }
            else if strengthScore == 100.0{
                saveOrUpdateMovie()
            }
        })
        .frame(height: 50)
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    //MARK: - function
    private func saveOrUpdateMovie() {
        if let item = editableItem {
            do {
                 let encrypted = try txtPassword.aesEncrypt()
                    viewModel.updateItem(item, accountName: txtName, email: txtEmail, password: encrypted)
                    print ("Encrypted:", encrypted)                
            }catch{
                print("error at encrypt password- ", error.localizedDescription)
            }
        } else {
            do {
                let encrypted = try txtPassword.aesEncrypt()
                viewModel.addItem(accountName: txtName, email: txtEmail, password: encrypted)
            }
            catch{
                print("error at encrypt password- ", error.localizedDescription)
            }
        }
        presentationMode.wrappedValue.dismiss()
        
    }
}
