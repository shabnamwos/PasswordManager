//
//  PasswordRowView.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI


struct PasswordRowView: View {
    
    //MARK: - variable
    @ObservedObject var password: PasswordTable 

    //MARK: - view
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text(password.accountName ?? "")
                    .setFont(.titleColor, .sfProMedium, 15)
                        
                    Text("********")
                        .setFont(.subtitleColor, .sfProMedium, 18)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.positiveButtonColor)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.subtitleColor, lineWidth: 0.5)
                )
                .background(Color.whiteColor)
                .cornerRadius(30)
            }
            
        }
    }
}
//#Preview {
//    PasswordRowView()
//}
