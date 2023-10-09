import SwiftUI
import UIKit

struct ImageGalleryView: View {
    @Binding var images: [UIImage]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(images.indices, id: \.self) { index in
                    VStack {
                        Image(uiImage: images[index])
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: UIScreen.main.bounds.width - 20) 
                        Button(action: {
                            images.remove(at: index)
                        }) {
                            Text("Delete")
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
