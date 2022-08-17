//
//  ContentView.swift
//  MacSample
//
//  Created by 이정동 on 2022/07/15.
//

import SwiftUI

struct PoiListView: View {
    @ObservedObject var poiData = PoiData()
    var body: some View {
        NavigationView{
            List{
                ForEach(poiData.rows, id:\.RESTRT_NM) { poi in
                    PoiItemView(poi: poi)
                }
            }
            .navigationTitle(Text("Restaurants"))
        }
        .onAppear{
            poiData.load()
        }
    }
}

struct PoiListView_Previews: PreviewProvider {
    static var previews: some View {
        PoiListView()
    }
}

struct PoiItemView: View {
    let poi: PoiItem
    var body: some View {
        NavigationLink {
            PoiDetailView(poi: poi)
        } label: {
            HStack{
                Image(systemName: "fork.knife.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading){
                    Text(poi.RESTRT_NM)
                        .font(.title)
                    Text(poi.REPRSNT_FOOD_NM)
                        .font(.headline)
                        .foregroundColor(Color.brown)
                    Text(poi.REFINE_ROADNM_ADDR)
                        .lineLimit(1)
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                }
            }
        }

    }
}
