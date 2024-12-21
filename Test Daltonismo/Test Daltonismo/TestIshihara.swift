import SwiftUI

struct IshiharaTestView: View {
   
    @State var tries = 0
    @State private var currentImageIndex = 0
    @State private var userAnswer = ""
    @State private var showingResult = false
    @State private var correctAnswersCount = 0
    
    var body: some View {
        if tries < 12{
        VStack {
            Image(testImageNames[currentImageIndex])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            TextField("Inserisci il numero", text: $userAnswer)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
            
            Button(action: {
                self.checkAnswer()
            }) {
                Text("Avanti")
                    .padding()
            }
            
            if showingResult && currentImageIndex != testImageNames.count - 1 {
                Text("Risposta corretta!")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        
        
    }else{
        switch correctAnswersCount {
        case 0..<5:
            Text("Hai indovinato \(correctAnswersCount) su 12, molto probabilmente sei daltonico, visita uno specialista")
        case 5..<8:
            Text("Hai indovinato \(correctAnswersCount) su 12, potresti essere daltonico ")
        case 8..<10:
            Text("Hai indovinato \(correctAnswersCount) su 12, qualche errore può capitare, ripeti il test")
        case 10...12:
            Text("Hai indovinato \(correctAnswersCount) su 12, hai un'ottima vista")
     
        default:
            Text("errore")
    
        }
        
    }
        
        
        
    }
    
    let imageValues: [String: String] = [
        "Ishihara_01": "74",
        "Ishihara_02": "6",
        "Ishihara_03": "16",
        "Ishihara_04": "2",
        "Ishihara_05": "29",
        "Ishihara_06": "7",
        "Ishihara_07": "45",
        "Ishihara_08": "5",
        "Ishihara_09": "97",
        "Ishihara_10": "8",
        "Ishihara_11": "42",
        "Ishihara_12": "3"
    ]

    func checkAnswer() {
        tries += 1
        let correctAnswer = self.answerForCurrentImage()
        if userAnswer == correctAnswer {
            correctAnswersCount += 1
            
        }
        
        // Passa alla prossima immagine dopo aver verificato la risposta
        if currentImageIndex < testImageNames.count - 1 {
            currentImageIndex += 1
            userAnswer = "" // Resetta la risposta per la nuova immagine
            showingResult = false // Nasconde il messaggio "Risposta corretta!"
        } else {
            showingResult = true // Mostra l'alert solo dopo l'ultima immagine
        }
    }
    
    func answerForCurrentImage() -> String {
        let currentImageName = testImageNames[currentImageIndex]
        return imageValues[currentImageName] ?? "" // Restituisci il valore corretto se presente nel dizionario
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
