//
//  ContentView.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var home: HomeModel?
 
    var body: some View {
        VStack {
            List {
                ScrollView(.horizontal) {
                    HStack {
                        Text("THIS")
//                        ForEach(products) { product in
//                            ProductTile(product: product)
//                        }
                    }
                }
            }.onAppear(perform: loadData)
        }
    }

    func loadData() {
        HomeService.homeModel { (result) in
            switch result {
            case .success(let model):
                self.home = model
            case .failure(let error):
                print(error.message)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
