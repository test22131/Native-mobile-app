import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    
    @Binding var images: [UIImage]

    typealias UIViewControllerType = UIImagePickerController

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }


    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            var parent: CameraView 

            init(_ parent: CameraView) {
                self.parent = parent
            }

            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let image = info[.originalImage] as? UIImage {
                    parent.images.append(image)
                }

                picker.dismiss(animated: true)
            }
        }
    }


struct CameraAppIcon: View {
    let iconName: String
    let label: String
    
    @Binding var images: [UIImage]
    @State private var showCamera = false
    @State private var showGallery = false

    var body: some View {
        VStack {
            Button(action: {
                showCamera = true
            }) {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .fullScreenCover(isPresented: $showCamera, content: {
                CameraView(images: $images)
            })

            Button(action: {
                showGallery.toggle()
            }) {
                Text("View Gallery")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            if showGallery {
                ImageGalleryView(images: $images)
            }

            Text(label)
        }
    }
}

