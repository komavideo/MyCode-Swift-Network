//
//  ContentView.swift
//  myapp
//
//  Created by xiaoma on 2020/10/01.
//

import SwiftUI

struct ContentView: View {    
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Page1", destination: Page1())
                NavigationLink("Page2", destination: Page2())
            }
            .navigationBarTitle("Load Image")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
