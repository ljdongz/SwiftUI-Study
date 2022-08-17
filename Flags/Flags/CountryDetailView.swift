//
//  CountryDetailView.swift
//  Flags
//
//  Created by 이정동 on 2022/07/13.
//

import SwiftUI

struct CountryDetailView: View {
    var country: (name: String, file: String)
    var body: some View {
        VStack {
            Image("\(country.file)")
                .resizable()
                .frame(width: 100, height: 100)
            List{
                Section(header: Text("info")){
                    Text("population : \(country.name.count) milions")
                        .frame(alignment: .trailing)
                }
                Section(header: Text("items")){
                    ForEach(1 ..< country.name.count) { index in
                        let startIndex = country.name.startIndex
                        let endIndex = country.name.index(startIndex, offsetBy: index)
                        let sub = String(country.name[startIndex ..< endIndex])
                        Text("Item \(index) : \(sub)")
                    }
                }
            }
        }
        .navigationTitle("\(country.name)")
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(country: Nations.contintents[0].countries[0])
    }
}
