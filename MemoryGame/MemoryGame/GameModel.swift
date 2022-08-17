//
//  GameModel.swift
//  MemoryGame
//
//  Created by 이정동 on 2022/07/14.
//

import Foundation

struct Card {
    enum State {
        case removed, closed, open
    }
    var state: State
    let number: Int
}

class GameModel:ObservableObject {
    static let rows = 5
    static let cols = 4
    
    @Published var cards = [Card]()    // var cards: [Card] = []
    @Published var flips = 0
    var openCardIndex: Int?
    private var count = 0
    var over: Bool{
        count == 0
    }
    
    func start() {
        cards = []
        count = 0
        flips = 0
        
        let max = GameModel.rows * GameModel.cols / 2
        for i in 1...max {
            cards.append(Card(state: .closed, number: i))
            cards.append(Card(state: .closed, number: i))
        }
        count = cards.count
        cards.shuffle()
    }
    init(){
        start()
    }
    
    func card(row: Int, col: Int) -> Card{      // row col에 위치한 카드 리턴
        cards[row * GameModel.cols + col]
    }
    
    func open(row:Int, col:Int){
        let index = row * GameModel.cols + col  // 선택한 카드
        
        if cards[index].state == .removed{
            return
        }
        if index == openCardIndex{
            return
        }
        
        if let oci = openCardIndex{ // openCardIndex 값을 저장한 oci가 nil이 아니면
            let num = cards[oci].number
            if num == cards[index].number {
                cards[index].state = .removed
                cards[oci].state = .removed
                openCardIndex = nil
                count -= 2
            }else{
                cards[oci].state = .closed
                cards[index].state = .open
                openCardIndex = index
                flips += 1
            }
        }else{
            cards[index].state = .open
            openCardIndex = index
            flips += 1
        }
    }
}
