//
//  ContentView.swift
//  Gesture
//
//  Created by 이정동 on 2022/07/13.
//

import SwiftUI

struct ContentView: View {
    @State var count = 0
    @State var num = 1
    @State var spinning = false
    @GestureState var angle = Angle.zero
    @State var visible = true
    var body: some View {
        let tap = TapGesture().onEnded{ count += 1}
        let longPress = LongPressGesture().onEnded{ _ in count += 10}
        let rotate = RotationGesture()
            .updating($angle) { angle, state, transaction in
                state = angle
            }
        VStack {
            Text("count = \(count) | angle = \(angle.degrees)")
            ZStack {
                Circle()
                    .stroke(.blue, lineWidth: 5)
                    .background(Circle().fill(
                        RadialGradient(colors: [Color.yellow, Color.green, Color.red], center: .center, startRadius: 0, endRadius: 80)
                    ))
                    .frame(width: 200, height: 200)
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 5)
//                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.red))
                    .frame(width: 50, height: 50)
                Text("CLick Me!")
                    .padding(50)
                    .gesture(tap)
                    .border(Color.red, width: 4)
                    .rotationEffect(.degrees(spinning ? 360 : 0))
                    .animation(
                        .linear(duration: 1).repeatForever(autoreverses: false), value: spinning ? 360 : 0
                    )
            }
            .onAppear {
                spinning = true
            }
            Toggle(isOn: $visible.animation(.linear)) {
                Text("Toggle...")
            }
            Button {
                spinning = !spinning
                if num == 10{
                    num = 0
                }
                num += 1
            } label: {
                Text("Capsule \(num)")
                    .padding(5)
                    .background(
                        Capsule()
                            .stroke(lineWidth: 5)
                    )
            }
            if visible {
                Path { path in
                    path.move(to: CGPoint(x: 200, y: 0))
                    path.addLine(to: CGPoint(x: 100, y: 200))
                    path.addLine(to: CGPoint(x: 300, y: 200))
                    
                    path.closeSubpath()
                }
                .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            }
            Spacer()
            HStack {
                Image(systemName: "pencil.and.outline")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("Long press")
            }
            .padding(50)
            .background(
                LinearGradient(colors: [Color.red, Color.yellow, Color.blue], startPoint: .topLeading , endPoint: .bottomTrailing)
            )
            
        }
        .gesture(
            rotate
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
