//
//  RoundedShape.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import Foundation
import SwiftUI
struct RoundedShape : Shape{
    var corners : UIRectCorner
    var radius : CGSize
    
    func path(in rect:CGRect) ->Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,cornerRadii: radius)
        
        return Path(path.cgPath)
    }
}
