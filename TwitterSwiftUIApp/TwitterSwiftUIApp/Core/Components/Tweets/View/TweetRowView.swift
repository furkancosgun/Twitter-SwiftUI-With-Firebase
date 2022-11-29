//
//  TweetRowView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI
import Kingfisher
import Firebase

struct TweetRowView: View {
    @ObservedObject var viewModel : TweetRowViewModel
    init(tweet : Tweet) {
        self.viewModel = TweetRowViewModel(tweet: tweet)
    }
    var body: some View {
        VStack(alignment: .leading,spacing: 20){
            HStack(alignment: .top){
                if let user = viewModel.tweet.user{
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50,height: 50)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading,spacing: 5){
                        HStack{
                            Text(user.fullname)
                            .font(.subheadline).bold()
                            Text(user.username)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                            Text("2h").font(.caption).foregroundColor(.gray)
                        }
                        Text(viewModel.tweet.caption).font(.subheadline).multilineTextAlignment(.leading)
                    }
                }
               
            }
            HStack{
                Button(action: {}, label: {
                    Image(systemName: "bubble.left").font(.subheadline)
                })
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "arrow.2.squarepath").font(.subheadline)
                })
                Spacer()
                Button(action: {
                    print(viewModel.tweet.didLike)
                    viewModel.tweet.didLike ?? false ? viewModel.unLikeTweet() : viewModel.likeTweet()
                }, label: {
                    Image(systemName: viewModel.tweet.didLike ?? false ? "heart.fill":"heart").font(.subheadline)
                        .foregroundColor(viewModel.tweet.didLike ?? false ? .red : .gray)
                })
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "bookmark").font(.subheadline)
                })
            }
            .foregroundColor(.gray)
            .padding(.vertical,3)
            .padding(.horizontal,6)
        }.padding(.horizontal)
        Divider()
    }
}

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
        TweetRowView(tweet: Tweet(caption: "jasdfoıjafıjfdas", timestamp: Timestamp(date: Date()), uid: "afsdafsd", likes: 0,user: User(username: "", fullname: "", profileImageUrl: "", email: "")))
    }
}

