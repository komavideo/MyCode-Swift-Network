//
//  Page1.swift
//  myapp
//
//  Created by xiaoma on 2020/10/01.
//

import SwiftUI

struct Page1: View {
    let imageUrl: URL? = URL(string: "https://i.ytimg.com/vi/c8T7wznZ6Sw/mqdefault.jpg")
    
    @State private var data: Data?
    
    private var image: UIImage? {
        get {
            if let data = self.data {
                return UIImage(data: data)
            } else {
                return nil
            }
        }
    }

    var body: some View {
        Group {
            if let image = self.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Color.gray
            }
        }
        .frame(width: 320, height: 180)
        .clipped()
        .onAppear(perform: {
            if let url = self.imageUrl, self.data == nil {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.data = data
                    }
                }
            }
        })
    }
}
