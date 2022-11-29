//
//  TweetService.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 28.11.2022.
//

import Firebase
import FirebaseFirestore
struct TweetService{
    
    func uploadTweet(caption:String,completion:@escaping (Bool)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let data = ["uid":uid,
                    "caption":caption,
                    "likes":0,
                    "timestamp":Timestamp(date: Date())] as [String:Any]
        
        Firestore.firestore()
            .collection("tweets")
            .document().setData(data){ error in
                if let error = error {
                    completion(false)
                    print("Failed To Upload Tweet With Error \(error)")
                    return
                }
                completion(true)
                print("DEBUG: Did Upload Tweet")
            }
        
    }
    
    func fetchTweets(completion:@escaping ([Tweet])->Void){
        Firestore.firestore().collection("tweets")
            .order(by: "timestamp",descending: false)
            .getDocuments(completion: {snap ,_ in
                guard let documents = snap?.documents else {return}
                
               let tweets = documents.compactMap({try? $0.data(as: Tweet.self)})
                print("Tweet Size:\(tweets.count)")
                completion(tweets)
            })
        
    }
    
    func fetchTweets(withUid uid:String,completion:@escaping ([Tweet])->Void){
        Firestore.firestore().collection("tweets")
            .whereField("uid", isEqualTo: uid )
            .getDocuments(completion: {snap ,_ in
                guard let documents = snap?.documents else {return}
                
               let tweets = documents.compactMap({try? $0.data(as: Tweet.self)})
                completion(tweets.sorted(by: {$0.timestamp.dateValue() > $1.timestamp.dateValue()  }))
            })
    }
    
    func likeTweet(_ tweet :Tweet,completion:@escaping (Bool)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else {return}
        
        let userLikesRef = Firestore.firestore().collection("users").document(uid).collection("user-likes")
        Firestore.firestore().collection("tweets").document(tweetId)
            .updateData(["likes":tweet.likes+1]){ _ in
                userLikesRef.document(tweetId).setData([:]){ _ in
                    completion(true)
                }
            }
    }
    
    func checkIfUserLikedTweet(_ tweet:Tweet,completion:@escaping (Bool)->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else {return}
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("user-likes")
            .document(tweetId).getDocument{ snap,_ in
                guard let snap = snap else {return}
                completion(snap.exists)
            }
    }
    
    func unlikeTweet(_ tweet:Tweet,completion:@escaping ()->Void){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let tweetId = tweet.id else {return}
        guard tweet.likes < 0 else {return}
        let userLikesRef = Firestore.firestore()
                                    .collection("users")
                                    .document(uid)
                                    .collection("user-likes")
        
        Firestore.firestore()
            .collection("tweets")
            .document(tweetId)
            .updateData(["likes":tweet.likes - 1]){ _ in
                userLikesRef.document(tweetId).delete{ _ in
                    completion()
                }
            }
    }
    
    func fetchLikedTweets(withUid uid:String,completion:@escaping([Tweet])->Void){
        var tweets = [Tweet]()
        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-likes")
            .getDocuments(completion: { snap,_ in
                guard let documents = snap?.documents else {return}
                
                documents.forEach({doc in
                    let tweetId = doc.documentID
                    
                    Firestore.firestore()
                        .collection("tweets")
                        .document(tweetId)
                        .getDocument{snap,_ in
                            guard let tweet = try? snap?.data(as:Tweet.self) else {return}
                            tweets.append(tweet)
                        }
                    completion(tweets)
                })
            })
    }
}
