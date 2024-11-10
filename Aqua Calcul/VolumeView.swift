import SwiftUI

struct VolumeView: View {
    @State private var length: String = ""     // Pour la longueur (cube)
    @State private var width: String = ""      // Pour la largeur (cube)
    @State private var height: String = ""     // Pour la hauteur (cube et cylindre)
    @State private var radius: String = ""     // Pour le rayon (cylindre)
    @State private var volume: Double? = nil   // Pour afficher le volume calculé
    @State private var selectedShape: ShapeType = .cube

    enum ShapeType {
        case cube
        case cylinder
    }

    var body: some View {
        VStack {
            // Titre de la vue
            Text("Calcul du Volume")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // Image conditionnelle en fonction de la forme sélectionnée
            if selectedShape == .cube {
                Image("volumeImage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding(.horizontal)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
            } else if selectedShape == .cylinder {
                Image("cylinderImage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding(.horizontal)
                    .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            
            Picker("Forme", selection: $selectedShape) {
                Text("Cube").tag(ShapeType.cube)
                Text("Cylindre").tag(ShapeType.cylinder)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if selectedShape == .cube {
                // Interface pour le calcul de volume d'un cube
                VStack {
                    TextField("Longueur en mètre", text: $length)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Largeur en mètre", text: $width)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Hauteur en mètre", text: $height)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
            } else if selectedShape == .cylinder {
                // Interface pour le calcul de volume d'un cylindre
                VStack {
                    TextField("Rayon en mètre", text: $radius)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Hauteur en mètre", text: $height)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
            }

            Button("Calculer le Volume") {
                calculateVolume()
                hideKeyboard() // Masque le clavier
            }
            .padding()
            .buttonStyle(.borderedProminent)

            if let calculatedVolume = volume {
                let volumeInLitres = calculatedVolume * 1000 // 1 m³ = 1000 L
                Text("Votre volume est de ")
                    .font(.title)
                + Text("\(calculatedVolume, specifier: "%.2f") m³ ")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                + Text("soit ")
                    .font(.title)
                + Text("\(volumeInLitres, specifier: "%.2f") Litres")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    
            }
        }
        .navigationTitle("Calcul de Volume")
    }

    private func calculateVolume() {
        // Remplace les virgules par des points pour convertir les valeurs en Double
        let lengthValue = length.replacingOccurrences(of: ",", with: ".")
        let widthValue = width.replacingOccurrences(of: ",", with: ".")
        let heightValue = height.replacingOccurrences(of: ",", with: ".")
        let radiusValue = radius.replacingOccurrences(of: ",", with: ".")

        if selectedShape == .cube {
            if let l = Double(lengthValue), let w = Double(widthValue), let h = Double(heightValue) {
                volume = l * w * h
            }
        } else if selectedShape == .cylinder {
            if let r = Double(radiusValue), let h = Double(heightValue) {
                volume = Double.pi * pow(r, 2) * h
            }
        }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct VolumeView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeView()
    }
}
