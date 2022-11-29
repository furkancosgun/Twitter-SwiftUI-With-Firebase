//
//  User.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 28.11.2022.
//

import FirebaseFirestoreSwift

struct User : Identifiable,Decodable{
    @DocumentID  var id :String?
    let username:String
    let fullname:String
    let profileImageUrl:String
    let email:String
}
