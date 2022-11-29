//
//  FeedViewModel.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 28.11.2022.
//

import Foundation

class FeedViewModel : ObservableObject{
    let service = TweetService()
    let userService = UserService()
    @Published var tweets = [Tweet]()
    
    init(){
        fetchTweets()
    }
    
    func fetchTweets(){
        service.fetchTweets(completion: { tweets in
            self.tweets = tweets
            for i in 0..<tweets.count{
                let uid = tweets[i].uid
                self.userService.fetchUser(withUid: uid, completion: { user in
                    print(user.profileImageUrl)
                    self.tweets[i].user = user 
                })
            }
        })
    }
}
