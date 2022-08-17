//
//  ContentView.swift
//  AlbumIsSample
//
//  Created by 이정동 on 2022/07/14.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var albumStore = AlbumStore.singleton
    var body: some View {
        NavigationView{
            List{
                ForEach(albumStore.albums, id: \.albumTitle) { album in
                    NavigationLink(destination: AlbumDetailView(album: album)) {
                        AlbumItemView(album: album)
                    }
                }
            }
            .navigationTitle(Text("Albums"))
        }
        .onAppear{
            albumStore.load()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AlbumItemView: View {
    static let imageSize = 48
    let album : Album
    @State var image: Image?
    var body: some View {
        HStack{
            loadAlbumImage()
                .resizable()
                .frame(
                    width: CGFloat(AlbumItemView.imageSize) ,
                    height: CGFloat(AlbumItemView.imageSize)
                )
            VStack(alignment: .leading){
                Text("\(album.albumTitle)")
                    .font(.headline)
                Spacer()
                Text("\(album.artistName)")
                    .font(.footnote)
                    .foregroundColor(Color.blue)
            }
        }
        
    }
    func loadAlbumImage() -> Image {
        if image != nil{
            return image!
        }
        return ImageStore.load(strUrl: album.image) { image in
            self.image = image
        }
    
    }
}

struct AlbumItemView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            AlbumItemView(album: Album(albumTitle: "1", artistName: "2", image: "3"))
        }
    }
}
