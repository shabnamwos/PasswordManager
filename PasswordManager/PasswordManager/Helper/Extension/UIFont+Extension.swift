//
//  UIFont+Extension.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import SwiftUI

typealias MainFont = AppFont

enum AppFont : String {
    case poppinsBold = "Poppins-Bold"
    case poppinsSemiBold = "Poppins-SemiBold"
    case roboto = "Roboto-Medium"
    case sfProMedium = "SF-Pro-Text-Medium"
    
    func with(size: CGFloat, font : MainFont) -> Font {
        return Font.custom("\(font.rawValue)", size: size)
    }
}

