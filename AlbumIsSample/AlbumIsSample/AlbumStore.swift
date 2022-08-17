//
//  AlbumStore.swift
//  AlbumIsSample
//
//  Created by 이정동 on 2022/07/14.
//

import Foundation
import SwiftUI

struct Album: Codable {     // json 데이터를 담을 구조체
    var albumTitle: String
    var artistName: String
    var image: String
}
struct AlbumData: Codable{      // json file의 형태
    var albums: [Album]
}

class AlbumStore: ObservableObject{
    static let singleton = AlbumStore()
    @Published var albums = [Album]()
    
    func load(){
        // url을 가져옴
        guard let url = Bundle.main.url(forResource: "res/albums.json", withExtension: "") else {
            return
        }
        
        // 데이터를 가져옴
        guard let data = try? Data(contentsOf: url) else{
            return
        }
        
        print("\(data)")
        let decoder = JSONDecoder()
        
        guard let albumData = try? decoder.decode(AlbumData.self, from: data) else{     // AlbumData.self = 데이터 형식이 AlbumData처럼 생겼다
            return
        }
        
        self.albums = albumData.albums
//        print("Load albums: \(albums[0])")
//        for album in albums{
//            print(album.artistName)
//        }
    }
}
