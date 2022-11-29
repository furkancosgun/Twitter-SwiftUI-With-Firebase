//
//  UserService.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 27.11.2022.
//
import FirebaseFirestoreSwift
import Firebase
struct UserService{
    func fetchUser(withUid uid:String,completion : @escaping(User)->Void){
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .getDocument{ snap,error in
                guard let snapshot = snap else {return}
                guard let user = try? snapshot.data(as: User.self) else {return}
                print("DEBUG: Fullname: \(user.fullname)")
                completion(user)
            }
    }
    
    func fetchUsers(completion : @escaping ([User])->Void){
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments{snap ,_ in
            guard let documents = snap?.documents else {return}
                
            let users = documents.compactMap({try? $0.data(as: User.self)})
         
            completion(users)
        }
    }
}
