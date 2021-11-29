//
//  ContentView.swift
//  Shared
//
//  CIS 137
//  Lab #4
//  Conrad Boucher & Les Poltrack
//  Nov 10, 2021
//
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: DogMemoryGameStore = DogMemoryGameStore()

    let screenWidth: CGFloat // use to size the cells based on teh size of the screen
    let cellWidth: CGFloat // Width of each Cell
    let cellHeight: CGFloat // Width of each Cell
    let cellSpacing: CGFloat // space cells apart same horizontally and vertically
    let gridItems: [GridItem]
    
    // START ADD FOR LAB 5
    @State var time = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showingAlert = false
    // END ADD FOR LAB 5
    
    var foundMatch: Bool {
        return viewModel.foundMatch
    }
    
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
            viewModel.gameOver ? Text("Play Again?")
                .font(.largeTitle)
                .foregroundColor(.green)
                .bold()
            :
            (!foundMatch ?
                Text("Match the Dogs!").font(.largeTitle).foregroundColor(.green).bold() :
                Text("Found a Match!").font(.largeTitle).foregroundColor(.black).bold())
            
            
            ProgressView("\(viewModel.pairsMatched) of \(viewModel.totalPairs) Pairs Matched (outlined in red)",
                         value: Float(viewModel.pairsMatched), total: Float(viewModel.totalPairs))
                .progressViewStyle((LinearProgressViewStyle(tint: .red)))

            
            HStack {
                // START: START, STOP, NEW_GAME BUTTONS
                ZStack {
                    Button("Start", action: {
                        viewModel.startTimer()
                    })
                        .font(.largeTitle)
                        .opacity(viewModel.isRunning || viewModel.gameOver ? 0.0 : 1.0)
                           
                    Button("Stop", action: {
                        viewModel.pauseGame()
                        showingAlert = true
                    })
                        .font(.largeTitle)
                        .opacity(!viewModel.isRunning ? 0.0 : 1.0)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Are you sure?"), message: Text("Stopping will end game."),
                                  primaryButton: .destructive(Text("End Game")) {
                                      print("End Game")
                                viewModel.resetGame()
                                time = 0
                                  },
                                  secondaryButton: .cancel() {
                                viewModel.startTimer()
                            })
                    }
                    Button("New Game", action: {
                        time = 0
                        viewModel.resetGame()
                    })
                        .font(.largeTitle)
                        .opacity(viewModel.gameOver ? 1.0 : 0.0)
                }
                // START: START, STOP, NEW_GAME BUTTONS

                Spacer()
                // SHOW THE TIME IN SECONDS
                Text("Time: \(time) \(time == 1 ? "second" : "seconds")")
                    .onReceive(timer){_ in
                        viewModel.isRunning ?
                        time += 1 : nil
                }
                    .font(.title)
         
            }
            LazyVGrid(columns: gridItems, alignment: .leading, spacing: cellSpacing) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card, height: cellHeight, width: cellWidth)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.red,
                                        lineWidth: card.isMatched ? 2 : 0))
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
    }
    
    struct CardView: View {
        var card: MemoryGame.Card
        let height: CGFloat
        let width: CGFloat
        
        init(card: MemoryGame.Card, height: CGFloat, width: CGFloat) {
            self.card = card
            self.height = height
            self.width = width
        }
        var flipDegrees: Double  {
            return card.isFaceUp ? 0 : 180.0
        }

        
        var body: some View {
            ZStack {
                Image(card.content).resizable().scaledToFit()
                    .flipView(flipDegrees)
                    .opacity(card.isFaceUp ? 1 : 0)
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: width, height: height)
                    .flipView(flipDegrees - 180.0)
                    .opacity(card.isFaceUp || card.isMatched ? 0 : 1)
                Image(card.content).resizable().scaledToFit()
                    .opacity(card.isMatched ? 1 : 0)
            }
            .animation(.easeInOut(duration: 1))
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

extension View {
      func flipView(_ degrees : Double) -> some View {
            return rotation3DEffect(Angle(degrees: degrees), axis: (x: 1.0, y: 1.0, z: 0.0))
      }
}
