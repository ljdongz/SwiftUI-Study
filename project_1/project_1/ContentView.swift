//
//  ContentView.swift
//  project_1
//
//  Created by 이정동 on 2022/07/11.
//

import SwiftUI

//struct TopButtonModifier: ViewModifier{
//    func body(content: Content) -> some View {
//        content
//            .frame(width: 50, height: 50)
//    }
//}

struct TopButton: View {
    enum Dir { case left, right}
    var enabled: Bool
    var dir: Dir
    var action: () -> Void
    var body: some View {
        var imageName: String = dir == .left ? "prev" : "next"
        if !enabled {
            imageName += "_d"
        }
        return Button {
            action()
        } label: {
            Image(imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fit)
        }
        .disabled(!enabled)
    }
}

struct ContentView: View {
    @State var pageNumber = 1
    var body: some View {
        VStack{
            HStack{
                Spacer()
                TopButton(enabled: pageNumber>1, dir: .left) {
                    if pageNumber > 1{
                        pageNumber -= 1
                    }
                }
                Spacer()
                Text("\(pageNumber) / 5")
                Spacer()
                TopButton(enabled: pageNumber<5, dir: .right) {
                    if pageNumber < 5{
                        pageNumber += 1
                    }
                }
                Spacer()
            }
            Spacer()
            Image("cat_\(pageNumber)")
                .resizable()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}


