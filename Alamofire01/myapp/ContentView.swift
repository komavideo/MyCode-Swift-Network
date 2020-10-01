//
//  ContentView.swift
//  myapp
//
//  Created by xiaoma on 2020/10/01.
//
//https://mydev-71bc0.web.app/videos.json

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var message: String = ""
    @State var videoList: VideoList = VideoList()
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Button("Start"){
                self.startLoad()
            }
            Text(self.message)
            Divider()
            ForEach(self.videoList.list) { video in
                Text(video.title)
                    .font(.body)
                    .lineLimit(1)
            }
        }
        .font(.title)
    }
    
    func startLoad(){
        let url = URL(string: "https://mydev-71bc0.web.app/videos.json")!
        
        AF.request(url).responseData { (response) in
            switch response.result {
            case let .success(data):
                guard let videoList = try? JSONDecoder().decode(VideoList.self, from: data) else {
                    updateMessage(message: "数据解析错误")
                    return
                }
                self.updateMessage(message: "取得\(videoList.list.count)条数据")
                self.videoList = videoList
                break
            case let .failure(error):
                updateMessage(message: error.localizedDescription)
                break
            }
        }
    }
    
    func updateMessage(message: String) {
        // 在主线程中更新message状态，保证线程安全
        self.message = message
        // Alamofire框架默认在主线程中处理数据，所以下面代码可以省略
        //DispatchQueue.main.async {}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
