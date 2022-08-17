//
//  ContentView.swift
//  Flags
//
//  Created by 이정동 on 2022/07/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //let countries = Nations.contintents[0].countries
        NavigationView {
            List{
                ForEach(Nations.contintents, id:\.region){ continent in
                    Section(header: Text(continent.region)) {
                        ForEach(continent.countries, id:\.name){ c in
                            NavigationLink(destination: {
                                CountryDetailView(country: c)
                            }) {
                                CountryView(country: c)
                            }
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationBarTitle("Countries")
        }
        .onAppear {
            let color = UIColor.cyan
            UINavigationBar.appearance().barTintColor = color
            UINavigationBar.appearance().backgroundColor = color
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CountryView: View {
    var country: (name: String,file: String)
    var body: some View {
        HStack {
            Image(country.file)
                .resizable()
                .frame(width: 50, height: 50)
            VStack (alignment: .leading){
                Text(country.name)
                    .font(Font.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.cyan)
                Text("\(country.name.count) million people")
                    .font(.footnote)
            }
        }
    }
}

struct ContryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(country: Nations.contintents[0].countries[0])
    }
}
