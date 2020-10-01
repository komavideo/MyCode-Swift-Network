//
//  Video.swift
//  myapp
//
//  Created by xiaoma on 2020/10/01.
//

import Foundation

struct VideoList: Codable {
    var pubdate: String = ""
    var list: [Video] = []
}

struct Video: Codable, Identifiable {
    var id: UUID = UUID()
    var title: String
    var category: String
    var itemsource: String
    var videoId: String
    var thumbnail: VideoThumbnail
    var channelTitle: String
    var publishedAt: String
    var viewCount: Int
    var likeCount: Int
    var commentCount: Int
    
    // 解析字段
    enum CodingKeys: String, CodingKey {
        case title
        case category
        case itemsource
        case videoId
        case thumbnail
        case channelTitle
        case publishedAt
        case viewCount
        case likeCount
        case commentCount
    }
}

struct VideoThumbnail: Codable {
    var url: String
    var width: Int
    var height: Int
}

