//
//  SideMenuRowView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 26.11.2022.
//

import SwiftUI

struct SideMenuRowView: View {
    var viewmodel : SideMenuViewModel
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: viewmodel.imageName)
                .foregroundColor(.gray)
                .font(.callout)
            
            Text(viewmodel.description)
                .font(.callout)
            Spacer()
        }.padding(.vertical)
            .foregroundColor(Color.black)
    }
}
/*
struct SideMenuRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuRowView(viewmodel: nil)
    }
}
*/
