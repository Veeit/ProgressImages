//
//  AddGroup.swift
//  DaiyProgress
//
//  Created by Veit Progl on 04.07.20.
//

import SwiftUI

struct CategorieStruct: Identifiable {
    var id: String
    var name: String
}

struct AddGroup: View {
    @Environment(\.managedObjectContext) var moc
    @State private var groupName = ""
    @State private var categorieName = ""
    @State private var categorieList:[CategorieStruct] = []

    var body: some View {
        NavigationView() {
            Form() {
                Section() {
                    TextField("Group Name", text: self.$groupName)
                }
                
                Section() {
                    HStack {
                        TextField("Categorie Name", text: self.$categorieName)
                        Button("Add", action: {
                            self.addCategorie()
                        })
                    }
                    List() {
                        ForEach(categorieList) { categorie in
                            Text(categorie.name)
                        }.onDelete(perform: deleteCategorie)
                    }
                }
            }.navigationBarTitle("Add Group")
                .navigationBarItems(leading: Text("Close"), trailing: Button("Done", action: {self.saveGroup()}))
        }
    }
    
    func saveGroup() {
        let newGroup = GroupEntities(context: self.moc)
        newGroup.id = UUID().uuidString
        newGroup.name = self.groupName
        
        try? self.moc.save()
    }
    
    func addCategorie() {
        categorieList.append(CategorieStruct(id: UUID().uuidString, name: categorieName))
        categorieName = ""
    }
    
    func deleteCategorie(at offsets: IndexSet) {
        for index in offsets {
            categorieList.remove(at: index)
        }
    }
}

struct AddGroup_Previews: PreviewProvider {
    static var previews: some View {
        AddGroup()
    }
}
