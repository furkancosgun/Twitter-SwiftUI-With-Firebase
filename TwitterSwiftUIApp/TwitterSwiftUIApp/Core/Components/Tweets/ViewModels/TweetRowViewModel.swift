//
//  TweetRowViewModel.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 28.11.2022.
//

import Foundation

class TweetRowViewModel : ObservableObject{
    private let tweetService = TweetService()
    @Published var tweet : Tweet
    init(tweet :Tweet){
        self.tweet = tweet
    }
    
    func likeTweet(){
        self.tweetService.likeTweet(tweet,completion: { _ in
            self.tweet.didLike = true
        })
    }
    
    func unLikeTweet(){
        self.tweetService.unlikeTweet(tweet, completion: {self.tweet.didLike = false})
    }
    func checkIfUserLikedTweet(){
        tweetService.checkIfUserLikedTweet(tweet, completion: { didLike in
            if didLike{
                self.tweet.didLike = true
            }
        })
    }
}
