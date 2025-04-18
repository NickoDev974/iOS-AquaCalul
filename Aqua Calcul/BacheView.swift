import SwiftUI

struct BacheView: View {
    @State private var bacheLength: String = ""
    @State private var bacheWidth: String = ""
    @State private var bacheHeight: String = ""
    @State private var initialBacheLength: Double? = nil
    @State private var initialBacheWidth: Double? = nil
    @State private var bacheRealLength: Double? = nil
    @State private var bacheRealWidth: Double? = nil

    var body: some View {
        VStack(spacing: 20) {
            Text("Calcul de bâche")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            Image("bacheImage")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.horizontal)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
            
            Text("Calcul de la taille de la bâche nécessaire pour un bassin cubique.")
                .font(.subheadline)
                .padding(.bottom, 20)
            
            VStack {
                TextField("Longueur (m)", text: $bacheLength)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Largeur (m)", text: $bacheWidth)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Hauteur (m)", text: $bacheHeight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            Button(action: {
                calculateBache()
                hideKeyboard() // Masque le clavier
            }) {
                Text("Calculer la taille de la bâche")
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .bold()
            }
            
            // Affichage des dimensions initiales de la bâche sans marges
            if let length = initialBacheLength, let width = initialBacheWidth {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Dimensions de la bâche sans marges:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    HStack {
                        Text("Longueur: ")
                        Text("\(String(format: "%.2f", length)) m")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text("Largeur: ")
                        Text("\(String(format: "%.2f", width)) m")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
            
            // Affichage des dimensions finales avec marges
            if let length = bacheRealLength, let width = bacheRealWidth {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Dimensions finales avec marges:")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    HStack {
                        Text("Longueur: ")
                        Text("\(String(format: "%.2f", length)) m")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    
                    HStack {
                        Text("Largeur: ")
                        Text("\(String(format: "%.2f", width)) m")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
        }
        .padding()
    }

    private func calculateBache() {
        // Remplace les virgules par des points pour la conversion en Double
        let lengthValue = bacheLength.replacingOccurrences(of: ",", with: ".")
        let widthValue = bacheWidth.replacingOccurrences(of: ",", with: ".")
        let heightValue = bacheHeight.replacingOccurrences(of: ",", with: ".")

        guard let length = Double(lengthValue),
              let width = Double(widthValue),
              let height = Double(heightValue) else {
            return
        }

        // Calcul des dimensions de la bâche sans marges
        initialBacheLength = length + (2 * height)
        initialBacheWidth = width + (2 * height)

        // Calcul des dimensions finales avec marges
        let bacheL = 1 + length + height * 2
        let bacheW = 1 + width + height * 2
        let availableWidths: [Double] = [4, 6, 8, 10]
        let selectedWidth = availableWidths.first(where: { $0 >= bacheW }) ?? availableWidths.last!
        let selectedLength = ceil(bacheL)

        bacheRealWidth = selectedWidth
        bacheRealLength = selectedLength
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct BacheView_Previews: PreviewProvider {
    static var previews: some View {
        BacheView()
    }
}
