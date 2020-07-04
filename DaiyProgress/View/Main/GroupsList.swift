//
//  GroupsList.swift
//  DaiyProgress
//
//  Created by Veit Progl on 01.07.20.
//

import SwiftUI

struct GroupsList: View {
    @FetchRequest(entity: GroupEntities.entity(), sortDescriptors: []) var groups: FetchedResults<GroupEntities>
    @Environment(\.managedObjectContext) var moc

    @State private var showAdd = false
    
    var body: some View {
        List {
            ForEach(groups, id: \.id) { group in
                NavigationLink(destination: ImageList(groupName: group.name ?? "", groupId: group.id ?? "")) {
                    Text(group.name ?? "no")
                }
            }.onDelete(perform: delete)
        }.sheet(isPresented: $showAdd) {
            AddGroup()
        }.onAppear(perform: {
//            print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last!);
        })
        .navigationBarItems(trailing: Button("Add", action: {
            self.showAdd.toggle()
        }))
        .navigationBarTitle("Groups")
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let group = groups[index]
            moc.delete(group)
            
            do {
                try self.moc.save()
            } catch {
                print("error")
            }
        }
    }
}

struct GroupsList_Previews: PreviewProvider {
    static var previews: some View {
        GroupsList()
    }
}
