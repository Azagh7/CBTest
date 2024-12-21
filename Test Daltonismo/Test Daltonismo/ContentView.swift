//
//  ContentView.swift
//  Test Daltonismo
//
//  Created by Aniello Casaburi on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            
            List {
                NavigationLink(destination: Test1()) {
                Text("Test minigioco colori")
                }
                
                NavigationLink(destination: IshiharaTestView()) {
                Text("Test di Ishihara")
                }

        }
            .navigationTitle("Test Daltonismo")
            
        }
        
        
    }
}

#Preview {
    ContentView()
}
