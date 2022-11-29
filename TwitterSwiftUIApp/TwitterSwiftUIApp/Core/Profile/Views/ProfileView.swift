//
//  ProfileView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @State private var selectedFilter : TweetsFilterViewModel = .tweets
    @ObservedObject var profileViewModel : ProfileViewModel
    @Environment(\.presentationMode) var mode
    private var user : User
    
    init(user: User) {
        self.user = user
        self.profileViewModel = ProfileViewModel(user: user)
    }
    
    @Namespace  var animation
    var body: some View {
        VStack(alignment: .leading){
            HeaderView
            ActionsButton
            UserInfoDetail
            TweetFilterBar
            TweetsView
            Spacer()
        }.navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: User(username: "", fullname: "", profileImageUrl: "", email: ""))
    }
}

extension ProfileView {
    var HeaderView : some View {
        ZStack(alignment: .bottomLeading){
            Color(.systemBlue)
                .ignoresSafeArea()//Ekranın Tamamını Kaplar
            
            VStack{
                Button{
                    mode.wrappedValue.dismiss()
                }label: {
                    Image(systemName: "arrow.left").resizable()
                        .frame(width: 20,height:15)
                        .foregroundColor(.white)
                }
                KFImage(URL(string: profileViewModel.user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 70,height:70)
                    .offset(x:10,y:30)
            }
        }.frame(height: 100)
    }
    
    var ActionsButton : some View  {
        HStack(spacing: 15){
            Spacer()
            Image(systemName: "bell.badge")
                .font(.title3)
                .padding(6)
                .overlay(Circle().stroke(Color.gray,lineWidth: 0.75))
                .foregroundColor(.gray)
                
            Button{
                
            }label: {
                Text("Edit Profile")
                    .font(.subheadline).bold()
                    .frame(width: 120,height: 32)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 0.75 ))
                    .foregroundColor(.black)
            }
        }.padding(.horizontal)
        
    }
    
    var UserInfoDetail : some View {
        VStack(alignment: .leading){
            Text(profileViewModel.user.fullname)
                .font(.title2)
                .bold()
            
            Text("@\(profileViewModel.user.username)")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Your Mom Is my favorite")
                .font(.subheadline)
                .padding(.vertical)
            
            HStack(spacing:30 ){
                HStack{
                    Image(systemName: "mappin.and.ellipse")
        
                    
                    Text("Turkey,Nevsehir")
       
                }
                HStack{
                    Image(systemName: "link")
                    Text("www.sj.com")
                }
                
            }.foregroundColor(.gray)
                .font(.caption)
            
            
            UserStatsView()
        }.padding(.horizontal)
    }
    
     var TweetFilterBar : some View {
        HStack{
            ForEach(TweetsFilterViewModel.allCases, id: \.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if  selectedFilter == item
                    {
                        Capsule().foregroundColor(Color(.systemBlue)).frame(height: 2)
                        .matchedGeometryEffect(id: "filter", in: animation)
                    }
                    else{
                        Capsule().foregroundColor(Color(.clear)).frame(height: 2)
                    }
                        
                        
                }.onTapGesture {
                    withAnimation(.easeInOut){
                        self.selectedFilter = item
                    }
                }
            }
        }.overlay(Divider().offset(x:0,y:16))
    }
    
    var TweetsView : some View {
        ScrollView{
            LazyVStack{
                ForEach(profileViewModel.tweets(withFilter: self.selectedFilter)){ tweet in
                    TweetRowView(tweet: tweet)
                }
            }
        }
    }
}
