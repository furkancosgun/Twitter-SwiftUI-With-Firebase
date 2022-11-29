//
//  Tweet.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 28.11.2022.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet:Identifiable,Decodable{
    @DocumentID var id:String?
    let caption:String
    let timestamp : Timestamp
    let uid : String
    let likes:Int
    var user : User?
    var didLike : Bool? = false
}
