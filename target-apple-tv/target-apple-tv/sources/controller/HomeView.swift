//
//  HomeView.swift
//  target-apple-tv
//
//  Created by Beau Nouvelle on 20/1/20.
//  Copyright © 2020 target. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    @State private var home: HomeModel?

    var body: some View {
        ScrollView {
            HStack {
                ForEach(home?.categoryItems ?? []) { category in
                    CategoryTile(category: category).frame(width: 200, height: 400, alignment: .center)
                    Divider()
                }
            }
        }.onAppear(perform: loadData)
            .frame(height: 400)
    }

    func loadData() {
        HomeService.homeModel { (result) in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.home = model
                }
            case .failure(let error):
                print(error.message)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
