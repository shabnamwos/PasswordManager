//
//  View+Extension.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI

extension View{
    
    func setFont(_ color : Color =  Color.black, _ font: MainFont, _ fontSize : CGFloat = 16) -> some View{
        self.font(font.with(size: fontSize, font: font))
            .foregroundColor(color)
    }

    //MARK: - shadow
    func dropShadowAndCorner(color : Color = Color.subtitleColor.opacity(0.2), cornerRadius : CGFloat = 15) -> some View {
        self .background(Color.subtitleColor.opacity(0.05))
            .cornerRadius(cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 1)
                .foregroundColor(color))
        
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorners(radius: radius, corners: corners) )
    }
}

struct RoundedCorners: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

