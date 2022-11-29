//
//  TweetsFilterViewModal.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import Foundation

enum TweetsFilterViewModel : Int,CaseIterable{
    case tweets
    case replies
    case likes
    
    var title : String {
        switch self{
        case .tweets : return "Tweets"
        case .replies : return "Replies"
        case .likes : return "Likes"
        }
    }
}
