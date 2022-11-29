//
//  ImageUploader.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 27.11.2022.
//

import Firebase
import FirebaseStorage
import UIKit

struct ImageUploader{
    static func uploadImage(image:UIImage,completion : @escaping(String)->Void){
        //UIimage to jpeg data
        guard let data = image.jpegData(compressionQuality: 0.5) else {return}
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath:"/profile_image/\(fileName)")
        
        ref.putData(data, completion: { _,error in
            if let error = error {
                print("DEBUG: Failed to upload image with error \(error)")
                return
            }
            ref.downloadURL(completion: { imageUrl,_ in
                guard let imageUrl = imageUrl?.absoluteString else {return}
                completion(imageUrl)
            })
            
        })
        
    }
}
