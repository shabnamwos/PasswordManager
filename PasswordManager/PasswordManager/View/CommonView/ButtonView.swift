//
//  ButtonView.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI

struct ButtonView: View {

    var label: String
    var background: Color = .positiveButtonColor
    var textColor: Color = .whiteColor
    let cornorRadius: CGFloat = 30
    var action: (() -> ())

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(label)
                .setFont(textColor, .poppinsBold, 15)
                .lineLimit(1)
            }
            .frame( maxWidth: .infinity,  maxHeight: 45)
        }
        .background(background)
        .cornerRadius(cornorRadius)
    }
}

#Preview {
    ButtonView(label: "add", action: {
        
    })
}

