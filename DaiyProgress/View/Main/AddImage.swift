//
//  AddImage.swift
//  DaiyProgress
//
//  Created by Veit Progl on 01.07.20.
//

import SwiftUI

struct AddImage: View {
    @State private var loadedImage: Image?
    @State private var imageData: UIImage?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @Environment(\.managedObjectContext) var moc
    var groupId: String
    
    var body: some View {
        VStack() {
            if loadedImage != nil {
                loadedImage?
                    .resizable()
                    .scaledToFit()
            }
            Text("Open Picker")
                .padding()
                .onTapGesture {
                    self.showingImagePicker = true
                }
            Text("Save")
                .onTapGesture {
                    self.saveImage()
            }

        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        loadedImage = Image(uiImage: inputImage)
        imageData = inputImage
    }
    
    func saveImage() {
        let newImage = ImageEntities(context: self.moc)
        newImage.id = UUID().uuidString
        newImage.name = "ww"
        newImage.data = inputImage?.pngData()
        newImage.date = Date()
        newImage.groupId = groupId
        
        print(newImage)
        
        do {
            try self.moc.save()
        } catch {
            print("error")
        }
    }
}
//
//struct AddImage_Previews: PreviewProvider {
//    static var previews: some View {
//        AddImage()
//    }
//}
