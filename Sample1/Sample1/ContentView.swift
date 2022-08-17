//
//  ContentView.swift
//  Sample1
//
//  Created by 이정동 on 2022/07/11.
//

import SwiftUI

struct BorderedShadow: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .border(Color.black, width: 3)
            .shadow(color: Color.gray, radius: 5, x: 2, y: 5)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                print("hello")
            } label: {
                Image(systemName: "poweroff")
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
            }
            Spacer()

            ExtractedView()
                .modifier(BorderedShadow())
            
            Image(systemName: "folder.badge.plus")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.yellow)
                .padding()
                .border(Color.black, width: 8)
                .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
                
            Spacer()
            Image("cat_2")
                .modifier(BorderedShadow())
            
            Spacer()
            Text("hello")
                .font(.footnote)
                .background(Color.cyan)
                .padding()
        }.padding().background(Color.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ExtractedView: View {
    var body: some View {
        Text("Hello, world!").padding().background()
    }
}
