import SwiftUI

struct CemaquaView: View {
    @State private var paintLength: String = ""      // Pour la longueur (cube)
    @State private var paintWidth: String = ""       // Pour la largeur (cube)
    @State private var paintHeight: String = ""      // Pour la hauteur (cube et cylindre)
    @State private var paintRadius: String = ""      // Pour le rayon (cylindre)
    @State private var surfaceToPaint: Double? = nil // Pour afficher la surface calculée
    @State private var selectedShape: ShapeType = .cube

    enum ShapeType {
        case cube
        case cylinder
    }

    var body: some View {
        VStack {
            Text("Calcul de la Surface à Peindre")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.blue)

            Image("cemaquaImage")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.horizontal)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)

            Picker("Forme", selection: $selectedShape) {
                Text("Cube").tag(ShapeType.cube)
                Text("Cylindre").tag(ShapeType.cylinder)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if selectedShape == .cube {
                VStack {
                    TextField("Longueur en mètre", text: $paintLength)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Largeur en mètre", text: $paintWidth)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Hauteur en mètre", text: $paintHeight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
            } else if selectedShape == .cylinder {
                VStack {
                    TextField("Rayon en mètre", text: $paintRadius)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Hauteur en mètre", text: $paintHeight)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                }
                .padding()
            }

            Button("Calculer la Surface à Peindre") {
                calculateSurfaceToPaint()
                hideKeyboard() // Masque le clavier
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .bold()

            if let calculatedSurface = surfaceToPaint {
                Text("La surface totale à peindre est de ")
                    .font(.title)
                + Text("\(calculatedSurface, specifier: "%.2f") m²")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
        .navigationTitle("Calcul de Surface à Peindre")
    }

    private func calculateSurfaceToPaint() {
        // Remplace les virgules par des points pour convertir les valeurs en Double
        let lengthValue = paintLength.replacingOccurrences(of: ",", with: ".")
        let widthValue = paintWidth.replacingOccurrences(of: ",", with: ".")
        let heightValue = paintHeight.replacingOccurrences(of: ",", with: ".")
        let radiusValue = paintRadius.replacingOccurrences(of: ",", with: ".")

        if selectedShape == .cube {
            if let length = Double(lengthValue),
               let width = Double(widthValue),
               let height = Double(heightValue) {
                let bottomSurface = length * width
                let sideSurface1 = 2 * (length * height)
                let sideSurface2 = 2 * (width * height)
                surfaceToPaint = bottomSurface + sideSurface1 + sideSurface2
            }
        } else if selectedShape == .cylinder {
            if let radius = Double(radiusValue),
               let height = Double(heightValue) {
                let lateralSurface = 2 * Double.pi * radius * height
                let baseSurface = 2 * Double.pi * pow(radius, 2)
                surfaceToPaint = lateralSurface + baseSurface
            }
        }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct CemaquaView_Previews: PreviewProvider {
    static var previews: some View {
        CemaquaView()
    }
}
