//
//  PoiDetailView.swift
//  MacSample
//
//  Created by 이정동 on 2022/07/15.
//

import SwiftUI
import MapKit

struct MapItem: Identifiable {
    let id = UUID()
    let poi: PoiItem
}

struct PoiDetailView: View {
    let poi: PoiItem
    @State var region: MKCoordinateRegion
    let mapItem: MapItem
    
    init(poi: PoiItem){
        self.poi = poi
        _region = State(initialValue: MKCoordinateRegion(
            center: poi.location,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01, longitudeDelta: 0.01
            ))
        )
//        region = MKCoordinateRegion(
//            center: poi.location,
//            span: MKCoordinateSpan(
//                latitudeDelta: 0.01, longitudeDelta: 0.01
//            )
//        )
        self.mapItem = MapItem(poi: poi)
    }
    
    var body: some View {
        GeometryReader { gr in
            ScrollView(.vertical){
                VStack(alignment: .leading){
                    VStack(alignment: .leading) {
                        PropertyView(imageName: "tram.circle"){
                            Text(poi.SIGUN_NM)
                        }
                        PropertyView(imageName: "location.circle"){
                            Text(poi.SIGUN_CD)
                        }
                        PropertyView(imageName: "fork.knife.circle"){
                            Text(poi.REPRSNT_FOOD_NM)
                        }
                        PropertyView(imageName: "phone.circle"){
                            Button {
                                let strUrl = "tel://" + poi.TASTFDPLC_TELNO
                                guard let url = URL(string: strUrl) else {
                                    return
                                }
                                UIApplication.shared.open(url)
                            } label: {
                                Text(poi.TASTFDPLC_TELNO)
                            }

                        }
                    }
                    .padding()
                    .background(Color.cyan.opacity(0.3))
                    .padding()
                    Map(coordinateRegion: $region,
                        annotationItems: [mapItem]
                    ){ mi in
                        MapMarker(
                            coordinate: mi.poi.location,
                            tint: .red
                        )
                    }
                        .frame(
                            width: gr.size.width,
                            height: gr.size.height / 2
                        )
                }
            }
        }
        .navigationTitle(poi.RESTRT_NM)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct PoiDetailView_Previews: PreviewProvider {
    static var previews: some View {
            PoiDetailView(
                poi: load()
            )
        }
        static func load() -> PoiItem {
            let item = try? JSONDecoder().decode(PoiItem.self, from: json.data(using: .utf8)!)
            return item!
        }
        static let json =
            "{" +
            " \"SIGUN_NM\": \"의정부시\", " +
            " \"SIGUN_CD\": \"41150\"," +
            " \"RESTRT_NM\": \"핏제리아 루카\"," +
            " \"REPRSNT_FOOD_NM\": \"마르게리따 피자\"," +
            " \"TASTFDPLC_TELNO\": \"031-851-3589\"," +
            " \"RM_MATR\": null," +
            " \"REFINE_LOTNO_ADDR\": \"경기도 의정부시 민락동 776-2번지\"," +
            " \"REFINE_ROADNM_ADDR\": \"경기도 의정부시 송현로82번길 17\"," +
            " \"REFINE_ZIP_CD\": \"11813\"," +
            " \"REFINE_WGS84_LOGT\": \"127.0904053\"," +
            " \"REFINE_WGS84_LAT\": \"37.7454846\"" +
            "}"
}

struct PropertyView<Content:View>: View {
    let imageName: String
    let content: () -> Content
    var body: some View {
        HStack {
            Image(systemName: "tram.circle")
                .resizable()
                .frame(width: 30, height: 30)
            content()
        }
    }
}

extension PoiItem {
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: Double(REFINE_WGS84_LAT)!,
            longitude: Double(REFINE_WGS84_LOGT)!
        )
    }
}
