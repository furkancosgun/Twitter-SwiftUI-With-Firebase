//
//  SearchBarView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 28.11.2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text : String
    var body: some View {
        HStack{
            TextField("Search..",text: $text)
                .padding(8)
                .padding(.horizontal,24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0,maxWidth: .infinity,alignment: .leading)
                            .padding(.leading,8)
                    }
                )
        }.padding(.horizontal,4)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant("asd"))
            .previewLayout(.sizeThatFits)
    }
}
