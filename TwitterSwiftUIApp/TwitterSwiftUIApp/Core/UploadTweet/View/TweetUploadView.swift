//
//  TweetUploadView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI
import Kingfisher

struct TweetUploadView: View {
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var authViewModel : AuthViewModel
    @ObservedObject var tweetViewModel = UploadTweetViewModel()
    @State private var text : String = ""
    var body: some View {
        VStack(){
            HStack{
                Button{
                    mode.wrappedValue.dismiss()
                }label: {
                    Text("Cancel").bold()
                }.padding()
                Spacer()
                Button{
                    tweetViewModel.uploadTweet(withCaption: text)
                }label: {
                    Text("Tweet")
                        .bold()
                        .padding(.vertical,5)
                        .padding(.horizontal,15)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }.padding()
            }
            HStack(alignment: .top){
                if let user = authViewModel.currentUser{
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .frame(width: 60,height: 60)
                        .scaledToFill()
                        .clipShape(Circle())
                    
                }
                TextAreaView(placeholder: "What The Fuck", text: $text)
            }.padding()
            Spacer()
        }
        .onReceive(tweetViewModel.$didUplaodTweet){ succes in
            if succes {
                mode.wrappedValue.dismiss()
            }
        }
    }
}


struct TweetUploadView_Previews: PreviewProvider {
    static var previews: some View {
        TweetUploadView()
    }
}


