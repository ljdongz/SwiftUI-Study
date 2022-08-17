//
//  AlbumDetailView.swift
//  AlbumIsSample
//
//  Created by 이정동 on 2022/07/15.
//

import SwiftUI

struct AlbumDetailView: View {
    let album: Album
    var body: some View {
        VStack {
            List{
                Image(systemName: "music.note.list")
                    .resizable()
                    .frame(width: 100, height: 100)
                Section(header: Text("info")){
                    Text("111")
                        .frame(alignment: .trailing)
                }
                Section(header: Text("items")){
                    ForEach(0 ..< album.albumTitle.count) { index in
                        let startIndex = album.albumTitle.startIndex
                        let endIndex = album.albumTitle.index(startIndex, offsetBy: index+1)
                        let sub = String(album.albumTitle[startIndex ..< endIndex])
                        Text("Item \(index+1) : \(sub)")
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("he")
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(album: Album(albumTitle: "Lee jeongdong", artistName: "2", image: "3"))
    }
}
