//
//  ContentView.swift
//  Shared
//
//  CIS 137
//  Partner Lab 2
//  Conrad Boucher & Les Poltrack
//  Oct 22, 2021
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: DogMemoryGameStore = DogMemoryGameStore()

    let screenWidth: CGFloat // use to size the cells based on teh size of the screen
    let cellWidth: CGFloat // Width of each Cell
    let cellHeight: CGFloat // Width of each Cell
    let cellSpacing: CGFloat // space cells apart same horizontally and vertically
    
    let gridItems: [GridItem]

    
    // INIT sets up the cell sizes based on the size of the screen
    init() {
        #if os(macOS)  // on Mac, not full screen width, just do a window
            screenWidth = 500.0
        #else  // on iOS, use the full screen width
            screenWidth = UIScreen.main.bounds.width
        #endif
        
        cellWidth = screenWidth * 0.3 // Have each about 1/3 of screen wide
        cellHeight = cellWidth * 2.0 / 3.0 // Pics are 3:2 aspect ratio
        cellSpacing = screenWidth * 0.05 // take up remaining space with void
        let dogGriditem = GridItem(.fixed(cellWidth), spacing: cellSpacing, alignment: .center)
        
        gridItems = [dogGriditem, dogGriditem, dogGriditem] // 3 cells wide
    }
    // BODY
    var body: some View {
        ScrollView(.vertical){
            Text("Game").font(.largeTitle).foregroundColor(.blue).bold()
            LazyVGrid(columns: gridItems, alignment: .leading, spacing: cellSpacing) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card, height: cellHeight, width: cellWidth)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 4))
                        
                }
            }
        }
    }
    
    struct CardView: View {
        var card: MemoryGame.Card
        let height: CGFloat
        let width: CGFloat
        //@State var isFaceUp: Bool = true // Moved to MemoryGame
        
        init(card: MemoryGame.Card, height: CGFloat, width: CGFloat) {
            self.card = card
            self.height = height
            self.width = width
        }
        var body: some View {
            ZStack {
                Image(card.content).resizable().scaledToFit()
                Rectangle().foregroundColor(.blue)
                    .frame(width: width, height: height)
                    .opacity(card.isFaceUp ? 0 : 1)
            }
            .onTapGesture {
                //isFaceUp = !isFaceUp
            }
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
