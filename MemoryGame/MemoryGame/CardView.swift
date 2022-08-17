//
//  CardView.swift
//  MemoryGame
//
//  Created by 이정동 on 2022/07/13.
//

import SwiftUI

struct CardView: View {
    var prefix: String
    var card: Card
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var frameIndex = 1
    var imageName: String {
        if card.state == .closed{
            return prefix + "_back"
        }
        return prefix + String(format: "_%02d_%02d", card.number, frameIndex)
    }
    
    var body: some View {
        if card.state == .removed{
            Image(systemName: "x.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.1)
        }else{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onReceive(timer) { _ in
                    frameIndex += 1
//                    if frameIndex > 8 {
//                        frameIndex = 1
//                    }
                    let img = UIImage(named: imageName)
                    if img == nil{
                        frameIndex = 1
                    }
                }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(1..<6) { num in
                HStack {
                    CardView(prefix: "z", card: Card(state: .open, number: num))
                    CardView(prefix: "z", card: Card(state: .removed, number: num))
                }
            }
        }
    }
}
