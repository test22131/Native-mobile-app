import SwiftUI
import UIKit

struct CameraAndGalleryView: View {
    @State private var images: [UIImage] = []
    @State private var showCamera = false
    @State private var showGallery = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Button(action: {
                showCamera = true
            }) {
                Image(systemName: "camera.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .fullScreenCover(isPresented: $showCamera) {
                CameraView(images: $images)
            }

            if !showGallery {
                Button(action: {
                    showGallery.toggle()
                }) {
                    Text("View Gallery")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }

            if showGallery {
                ImageGalleryView(images: $images) 
            }
            Spacer()
        }
    }
}

struct CameraAndGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        CameraAndGalleryView()
    }
}
