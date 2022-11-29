//
//  FeedView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject private var feedViewModel = FeedViewModel()
    @State private var showNewTweetView = false
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            //Bottom Trailing ile sag aşagıya yeni tweet butonu ekledik
            ScrollView{
                LazyVStack{
                    ForEach(feedViewModel.tweets){tweet  in
                        TweetRowView(tweet: tweet)
                            .padding(.vertical,5)
                    }
                }
            }
            
            
            Button{
                showNewTweetView.toggle()
            }label: {
                Image(systemName: "doc")
                    .resizable()
                    .frame(width: 20,height: 30)
                    .padding()
            }.background(Color(.systemBlue))
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
            //Ekranı Tamamen kaplayarak Yeni gorunum oluşturur
                .fullScreenCover(isPresented: $showNewTweetView, content:{
                    TweetUploadView()
                })
        }.navigationBarTitleDisplayMode(.inline )
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
