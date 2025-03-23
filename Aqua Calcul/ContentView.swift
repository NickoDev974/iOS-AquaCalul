import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        ZStack {
            // TabView en arrière-plan (prend toute la vue)
            TabView {
                VolumeView()
                    .tabItem {
                        Label("Volume", systemImage: "cube.fill")
                    }

                TreatmentView()
                    .tabItem {
                        Label("Traitement", systemImage: "pills.fill")
                    }

                BacheView()
                    .tabItem {
                        Label("Bâche", systemImage: "rectangle.fill.on.rectangle.angled.fill")
                    }

                CemaquaView()
                    .tabItem {
                        Label("Cemaqua", systemImage: "paintbrush.fill")
                    }
            }
            .edgesIgnoringSafeArea(.bottom)

            // Logo centré au-dessus du TabView
            //VStack {
              //  Image("Logo")
                //    .resizable()
                  //  .scaledToFit()
                    //.frame(maxWidth: 300, maxHeight: 300) // Taille ajustée
                   // .padding(.top, 50)

                //Spacer() // Pousse l’image vers le haut
           // }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
