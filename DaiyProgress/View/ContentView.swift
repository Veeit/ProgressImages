//
//  ContentView.swift
//  DaiyProgress
//
//  Created by Veit Progl on 01.07.20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView() {
            GroupsList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
