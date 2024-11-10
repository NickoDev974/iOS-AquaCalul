import SwiftUI

struct TreatmentView: View {
    @State private var treatmentPerLitre: String = ""  // Traitement en ml pour 1 litre
    @State private var volumeOfDosage: String = ""     // Volume du dosage en litres
    @State private var volumeToTreat: String = ""      // Volume à traiter en litres
    @State private var result: Double? = nil           // Pour afficher le résultat

    var body: some View {
        VStack {
            Text("Calcul de Traitement")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Image("traitementImage")
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .padding(.horizontal)
                .shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 5)
            
            VStack {
                TextField("Traitement en ml", text: $treatmentPerLitre)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Volume de dosage en L", text: $volumeOfDosage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                TextField("Volume à traiter en L", text: $volumeToTreat)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            Button("Calculer le Traitement") {
                calculateTreatment()
                hideKeyboard() // Masque le clavier
            }
            .padding()
            .buttonStyle(.borderedProminent)

            if let calculatedResult = result {
                Text("Quantité de traitement : ")
                    .font(.title)
                + Text("\(calculatedResult, specifier: "%.2f") ml")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
            }
        }
        .navigationTitle("Calcul de Traitement")
    }

    private func calculateTreatment() {
        // Remplace les virgules par des points pour convertir les valeurs en Double
        let treatmentValue = treatmentPerLitre.replacingOccurrences(of: ",", with: ".")
        let volumeDosageValue = volumeOfDosage.replacingOccurrences(of: ",", with: ".")
        let volumeToTreatValue = volumeToTreat.replacingOccurrences(of: ",", with: ".")
        
        if let treatment = Double(treatmentValue),
           let volumeDosage = Double(volumeDosageValue),
           let volumeToTreat = Double(volumeToTreatValue) {
            let totalTreatment = (treatment / volumeDosage) * volumeToTreat
            result = totalTreatment
        }
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    TreatmentView()
}
