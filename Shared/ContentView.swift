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
    
    @ObservedObject var viewModel: DogMemoryGameStore

    let screenWidth: CGFloat // use to size the cells based on teh size of the screen
    let cellWidth: CGFloat // Width of each Cell
    let cellHeight: CGFloat // Width of each Cell
    let cellSpacing: CGFloat // space cells apart same horizontally and vertically
    let gridItems: [GridItem]
    let dogImages = ["airedale_terrier", "american_foxhound","dutch_shepherd",
                   "havanese", "labrador_puppy", "leonberger",
                   "mudi", "norwegian_lundehund", "old_labrador",
                   "pharaoh_hound", "scottish_terrier", "tosa"
                    ]
    
    // INIT sets up the cell sizes based on the size of the screen
    init() {
        #if os(macOS)  // on Mac, not full screen width, just do a window
            screenWidth = 500.0
        #else  // on iOS, use the full screen width
            screenWidth = UIScreen.main.bounds.width
        #endif
        
        cellWidth = screenWidth * 0.3 // Have each about 1/3 of screen wide
        cellSpacing = screenWidth * 0.05 // take up remaining space with void
        cellHeight = cellWidth * 2.0 / 3.0 // Pics are 3:2 aspect ratio
        let dogGriditem = GridItem(.fixed(cellWidth), spacing: cellSpacing, alignment: .center)
        
        gridItems = [dogGriditem, dogGriditem, dogGriditem] // 3 cells wide
        
        
    }
    // BODY
    var body: some View {
        ScrollView(.horizontal){
            LazyVGrid(columns: gridItems, alignment: .leading, spacing: cellSpacing) {
                ForEach(dogImages, id:\.self) { dogKey in
                    CardView(image: dogKey, height: cellHeight, width: cellWidth)
                        .onTapGesture {
                        }
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 4))
                        
                }
            }
        }.navigationTitle(Text("Title"))
    }
    struct CardView: View {
        var image: String
        let height: CGFloat
        let width: CGFloat
        @State var isFaceUp: Bool = true // Moved to MemoryGame
        
        init(image: String, height: CGFloat, width: CGFloat) {
            self.image = image
            self.height = height
            self.width = width
        }
        var body: some View {
            ZStack {
                Image(image).resizable().scaledToFit()
                Rectangle().foregroundColor(.blue)
                    .frame(width: width, height: height)
                    .opacity(isFaceUp ? 0 : 1)
            }
            .onTapGesture {
                isFaceUp = !isFaceUp
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
