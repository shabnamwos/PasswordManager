//
//  TextFieldView.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI

struct TextFieldView: View {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .setFont(.titleColor, .roboto, 16)
                .keyboardType(keyboardType)
        }
        .padding()
        .background(Color.whiteColor)
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
            .stroke(Color.subtitleColor, lineWidth: 0.5)
            
        )
    }
}

struct TextFieldView_Previews: PreviewProvider {
    @State static var text = ""

    static var previews: some View {
        TextFieldView(placeholder: "Mobile Number", text: $text)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

