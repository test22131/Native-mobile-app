import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3), spacing: 30) {
                    AppIcon(iconName: "camera.fill", label: "Camera", destination: AnyView(CameraAndGalleryView()))
                    AppIcon(iconName: "phone.arrow.up.right.fill", label: "In Call", destination: AnyView(PhoneInCall()))
                    AppIcon(iconName: "person.crop.circle.fill", label: "Contacts", destination: AnyView(PhoneContacts()))
                }
                .padding(EdgeInsets(top: 30, leading: 40, bottom: 30, trailing: 40))
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Home")
                        .font(.system(size: 50, weight: .bold))
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
        }
    }
}

struct AppIcon: View {
    let iconName: String
    let label: String
    let destination: AnyView

    var body: some View {
        VStack {
            NavigationLink(destination: destination) {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(.accentColor)
                        .frame(width: 80, height: 80)
                    Image(systemName: iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                }
            }
            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .padding(.top, 8)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
