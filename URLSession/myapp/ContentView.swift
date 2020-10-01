//
//  ContentView.swift
//  myapp
//
//  Created by xiaoma on 2020/10/01.
//

import SwiftUI

//https://mydev-71bc0.web.app/videos.json

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
        var request = URLRequest(url: url)
        // 12秒超时
        request.timeoutInterval = 12
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                updateMessage(message: error.localizedDescription)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                updateMessage(message: "请求出错")
                return
            }
            guard let data = data else {
                updateMessage(message: "木有数据")
                return
            }
            guard let videoList = try? JSONDecoder().decode(VideoList.self, from: data) else {
                updateMessage(message: "数据解析错误")
                return
            }
            self.updateMessage(message: "取得\(videoList.list.count)条数据")
            self.videoList = videoList
        }
        // 开始执行任务
        task.resume()
    }
    
    func updateMessage(message: String) {
        DispatchQueue.main.async {
            // 在主线程中更新message状态，保证线程安全
            self.message = message
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
