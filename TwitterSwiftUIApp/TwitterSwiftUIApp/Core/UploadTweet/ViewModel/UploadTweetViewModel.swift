//
//  UploadTweetViewModel.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 28.11.2022.
//

import Foundation

class UploadTweetViewModel : ObservableObject{
    @Published var didUplaodTweet = false
    let service = TweetService()
    func uploadTweet(withCaption caption:String){
        service.uploadTweet(caption: caption, completion: { succes in
            if succes{
                self.didUplaodTweet = true
            }else{
                self.didUplaodTweet = false
            }
        })
    }
}
