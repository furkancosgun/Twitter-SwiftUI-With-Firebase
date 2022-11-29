//
//  ExploreView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject private var exploreViewModel = ExploreViewModel()
    
    var body: some View {
            VStack {
                SearchBarView(text: $exploreViewModel.searchText)
                    .padding()
                ScrollView{
                    LazyVStack{
                        ForEach(exploreViewModel.searchableUsers){ user in
                        NavigationLink{
                                ProfileView(user: user)
                            }label: {
                                UserRowView(user: user)
                            }
                        }
                    }
                }
            }.navigationTitle("Explorer")
            .navigationBarTitleDisplayMode(.inline)
    
        }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
