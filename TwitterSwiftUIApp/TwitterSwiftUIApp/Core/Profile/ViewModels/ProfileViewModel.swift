//
//  ProfileViewModel.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 28.11.2022.
//

import Foundation

class ProfileViewModel : ObservableObject{
    @Published var tweets = [Tweet]()
    @Published var likedTweets = [Tweet]()
    private var tweetService = TweetService()
    var user : User
    
    init(user: User) {
        self.user = user
        self.fetchUserTweets()
        self.fetchLikedTweets()
    }
    func tweets(withFilter filter : TweetsFilterViewModel)->[Tweet]{
        switch filter{
        case .tweets:
            return tweets
        case .likes:
            return likedTweets
        case .replies:
            return tweets
            
        }
    }
    func fetchLikedTweets(){
        guard let uid = user.id else {return}
        tweetService.fetchLikedTweets(withUid: uid) { tweets in
            self.likedTweets = tweets
            for i in 0..<tweets.count{
                self.likedTweets[i].user = self.user
            }
        }
    }
    
    func fetchUserTweets(){
        print("USER UID: \(user.id)")
        guard let uid = user.id else {return}
        tweetService.fetchTweets(withUid: uid, completion: { tweets in
            self.tweets = tweets
            for i in 0..<tweets.count{
                self.tweets[i].user = self.user
            }
        })
    }
    
  
}
