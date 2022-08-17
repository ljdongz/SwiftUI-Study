//
//  ContentView.swift
//  Project_2
//
//  Created by 이정동 on 2022/07/12.
//

import SwiftUI

struct ContentView: View {
    @State var count = 0
    @State var name:String = ""
    @State var angle = 0.0
    var body: some View {
        VStack {
            Text("Name : \(name) | Count : \(count) | Slider : \(angle)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .rotationEffect(Angle.degrees(angle))
                .animation(.easeIn(duration: 1.0), value: angle)
                
            Image(systemName: "square.and.arrow.up.circle.fill")
                .font(.largeTitle)
            Button {
                count += 1
            } label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
            }
            TextField("Enter your name here", text: $name)
                .frame(width: 200)
            Slider(value: $angle, in: 0...720)
                .frame(width: 200)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
