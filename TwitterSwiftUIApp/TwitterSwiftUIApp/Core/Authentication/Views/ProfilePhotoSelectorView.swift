//
//  ProfilePhotoSelectorView.swift
//  TwitterSwiftUIApp
//
//  Created by Furkan on 27.11.2022.
//

import SwiftUI

struct ProfilePhotoSelectorView: View {
    @State private var showImagePicker = false
    @State private var selectedImage : UIImage?
    @State private var profileImage : Image?
    @State private var isLoading  = false
    @EnvironmentObject var authViewModel : AuthViewModel
    var body: some View {
        VStack{
            AuthHeaderView(firstTitle: "Setup Account", secondTitle: "Add a Profile Photo")
            
            Button{
                showImagePicker.toggle()
            }label: {
                if let profileImage = profileImage {
                    profileImage
                        .resizable()
                        .frame(width: 300,height: 300)
                }else{
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                }
            }
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $showImagePicker,
                   onDismiss: loadImage){
                ImagePicker(selectedImage: $selectedImage)
            }
            
            if isLoading {
                
                ProgressView()
                .frame(width: UIScreen.main.bounds.width - 50,height: 50)
                .scaleEffect(1, anchor: .center)
                .background(Color.blue)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .clipShape(Capsule())
            }else{
                
                
                if let selectedImage = selectedImage {
                    Button{
                        isLoading = true
                        authViewModel.uploadProfileImage(selectedImage)
                        
                    }label: {
                        Text("Continue")
                    }
                    .frame(width: UIScreen.main.bounds.width - 50,height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                
            }
           
            
            Spacer()
        }.ignoresSafeArea()
    }
    func loadImage(){
        guard let selectedImage = selectedImage else {return}
        print("DEBUG IMAGE: \(selectedImage)")
        profileImage = Image(uiImage: selectedImage)
    }
}

private struct ProfileImageModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width: 100,height: 100)
        
    }
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoSelectorView()
    }
}
