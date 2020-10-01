//
//  Page2.swift
//  myapp
//
//  Created by xiaoma on 2020/10/01.
//

import SwiftUI
import SDWebImageSwiftUI

struct Page2: View {
    let imageUrl: URL? = URL(string: "https://i.ytimg.com/vi/c8T7wznZ6Sw/mqdefault.jpg")

    var body: some View {
        WebImage(url: self.imageUrl)
            .placeholder{Color.gray}
            .resizable()
            .onSuccess(perform: { (_) in
                print("Success")
                SDWebImageManager.shared.imageCache.clear(with: .all, completion: nil)
            })
            .onFailure(perform: { (_) in
                print("Failure")
            })
            .scaledToFill()
            .frame(width: 320, height: 180, alignment: .center)
            .clipped()
            
    }
}

struct Page2_Previews: PreviewProvider {
    static var previews: some View {
        Page2()
    }
}
