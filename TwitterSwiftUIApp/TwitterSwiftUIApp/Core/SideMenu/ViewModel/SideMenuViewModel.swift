//
//  SideMenuViewModel.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import Foundation

enum SideMenuViewModel : Int,CaseIterable{
    case profile
    case lists
    case bookmarks
    case logout
    
    var description : String{
        switch self{
        case .bookmarks : return "Bookmarks"
        case .lists : return "Lists"
        case .profile : return "Profile"
        case .logout : return "Logout"
        }
    }
    
    var imageName : String {
        switch self{
        case .bookmarks : return "bookmark"
        case .lists : return "list.bullet"
        case .profile : return "person"
        case .logout : return "arrow.left.square"
        }
    }
}
