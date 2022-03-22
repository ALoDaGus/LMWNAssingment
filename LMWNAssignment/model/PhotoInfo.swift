//
//  PhotoInfo.swift
//  LMWNAssignment
//
//  Created by TPmac on 19/3/2565 BE.
//

import Foundation

struct PhotosResponse: Decodable{
    var total_pages: Int
    var photos: [PhotoDetail]
}

struct PhotoDetail: Decodable{
    var width: Int
    var height: Int
    var image_url: [String]
    var name: String
    var description: String
    var votes_count: Int
    var camera: String
    var user: User
}

struct User: Decodable{
    var fullname: String
    var avatars: Avatars
}

struct Avatars: Decodable{
    var large: large
}

struct large: Decodable{
    var https: String
}

