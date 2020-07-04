//
//  ImageList.swift
//  DaiyProgress
//
//  Created by Veit Progl on 01.07.20.
//

import SwiftUI

struct ImageList: View {
    @Environment(\.managedObjectContext) var moc
    
//    @FetchRequest(entity: ImageEntities.entity(), sortDescriptors: []) var allImages: FetchedResults<ImageEntities>
    var images: FetchRequest<ImageEntities>
    var groupName: String
    var groupID: String
    
    
    init(groupName: String, groupId: String) {
        self.groupName = groupName
        self.groupID   = groupId
        self.images    = FetchRequest<ImageEntities>(entity: ImageEntities.entity(), sortDescriptors: [NSSortDescriptor(key: #keyPath(ImageEntities.date), ascending: false)], predicate:  NSPredicate(format: "%K = %@", "groupId", groupId))
    }
    
    var body: some View {
        List {
            ForEach(images.wrappedValue, id: \.id) { ima in
//                if ima.data != nil {
                    NavigationLink(destination: ImageDetail()) {
                        Image(uiImage: UIImage(data: ima.data!)!)
                            .resizable()
                            .scaledToFit()
                    }
//                }
            }.onDelete(perform: delete)
        }
        .listStyle(GroupedListStyle())
        .onAppear(perform: {
            print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);
        })
        .navigationBarTitle(groupName)
        .navigationBarItems(trailing: NavigationLink(destination: AddImage(groupId: groupID), label: {
            Text("Add")
        }))
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let image = images.wrappedValue[index]
            moc.delete(image)
            
            do {
                try self.moc.save()
            } catch {
                print("error")
            }
        }
    }
}

//struct ImageList_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageList()
//    }
//}
