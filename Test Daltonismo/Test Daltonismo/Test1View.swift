import SwiftUI

struct Test1: View {
    let gridSize = 15
    let circleSize: CGFloat = 24
    
    @State var tries: Int = 0
    @State var score: Int = 0
    @State var value: Int = 0
    @State private var rowIndexArray: [Int] = []
    @State private var columnIndexArray: [Int] = []
    
    
    init() {
           let initialValue = Int.random(in: 1...5)
           _value = State(initialValue: initialValue)
           
           var rowIndexes = [Int]()
           var columnIndexes = [Int]()
           
           for _ in 0..<initialValue {
               let randomRowIndex = Int.random(in: 0..<gridSize)
               let randomColumnIndex = Int.random(in: 0..<gridSize)
               rowIndexes.append(randomRowIndex)
               columnIndexes.append(randomColumnIndex)
           }
           
           _rowIndexArray = State(initialValue: rowIndexes)
           _columnIndexArray = State(initialValue: columnIndexes)
       }

    
    func generateRandomIndexes() {
        let numberOfTimes = Int.random(in: 1...5)
        value = numberOfTimes
        rowIndexArray.removeAll()
        columnIndexArray.removeAll()
        
        for _ in 0..<numberOfTimes {
            let randomIndex = Int.random(in: 0..<gridSize) // Use gridSize to ensure within bounds
            let randomIndex2 = Int.random(in: 0..<gridSize)
            rowIndexArray.append(randomIndex)
            columnIndexArray.append(randomIndex2)
        }
    }
    
    var body: some View {
       
        if tries < 10{
            
            VStack(spacing: 0) {
                Spacer()
                Text("Quanti colori completamente diversi vedi?")
                Spacer()
                ForEach(0..<gridSize, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0..<gridSize, id: \.self) { column in
                            let isHighlighted = self.isCellHighlighted(row: row, column: column)
                            
                            Circle()
                                .foregroundColor(isHighlighted ? winColor() : randomColor())
                                .frame(width: self.circleSize, height: self.circleSize)
                        }
                    }
                }
                Spacer()
                HStack(spacing: 12) {
                    ForEach(1..<6) { number in
                        Button("\(number)") {
                            tries += 1
                            if value == number {
                                score += 1
                            }
                            generateRandomIndexes()
                            print("score: \(score)")
                            print("try: \(tries)")
                        }
                        .frame(width: 30, height: 30)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.black)
                        .foregroundColor(Color.white)
                        .cornerRadius(24)
                    }
                }
                Spacer()
                
            }
        
            
        }else{
            
            VStack{
                switch score {
                case 0..<4:
                    Text("Hai indovinato \(score) su 10, molto probabilmente sei daltonico, visita uno specialista")
                case 4..<6:
                    Text("Hai indovinato \(score) su 10, potresti essere daltonico ")
                case 6..<8:
                    Text("Hai indovinato \(score) su 10, qualche errore può capitare, ripeti il test")
                case 8...10:
                    Text("Hai indovinato \(score) su 10, hai un'ottima vista")
                    
                default:
                    Text("errore")
                    
                }
            }
            
            HStack{
                Button("Riprova"){
                                    }
                
                Button("Torna al menù"){
                   ContentView()
                }
                
                
            }
        }
        
    }
    
    func winColor() -> Color {
        let red = Double.random(in: 157...163) / 255.0
        let green = Double.random(in: 117...123) / 255.0
        let blue = Double.random(in: 57...60) / 255.0
        return Color(red: red, green: green, blue: blue)
    }
    
    
    
    func randomColor() -> Color {
        let red = Double.random(in: 95...115) / 255.0
        let green = Double.random(in: 110...130) / 255.0
        let blue = Double.random(in: 55...75) / 255.0
        return Color(red: red, green: green, blue: blue)
    }
    
    func isCellHighlighted(row: Int, column: Int) -> Bool {
        for i in 0..<value {
            if rowIndexArray[i] == row && columnIndexArray[i] == column {
                return true
            }
        }
        return false
    }
}

struct GridOverlay_Previews: PreviewProvider {
    static var previews: some View {
        Test1()
    }
}

