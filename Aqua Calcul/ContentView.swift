//
//  ContentView.swift
//  Aqua Calcul
//
//  Created by Nicko B on 05/11/2024.
//

import SwiftUI
import SwiftData

// Vue pour le calcul de traitement
//struct TreatmentView: View {
//    var body: some View {
//        Text("Calcul de Traitement")
        // Ajoutez ici votre interface pour le calcul de traitement
//    }
//}

// Vue pour le calcul de bâche
//struct BacheView: View {
  //  var body: some View {
    //    Text("Calcul de Bâche")
        // Ajoutez ici votre interface pour le calcul de bâche
   // }
//}

// Vue pour le calcul Cemaqua
//struct CemaquaView: View {
  //  var body: some View {
    //    Text("Calcul de Cemaqua")
        // Ajoutez ici votre interface pour le calcul de Cemaqua
    //}
//}

// Vue principale avec navigation par onglets
struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        TabView {
            // Onglet pour le calcul de volume
            VolumeView()
                .tabItem {
                    Label("Volume", systemImage: "cube.fill")
                }

            // Onglet pour le calcul de traitement
            TreatmentView()
                .tabItem {
                    Label("Traitement", systemImage: "pills.fill")
                }

            // Onglet pour le calcul de bâche
            BacheView()
                .tabItem {
                    Label("Bâche", systemImage: "rectangle.fill.on.rectangle.angled.fill")
                }

            // Onglet pour le calcul Cemaqua
            CemaquaView()
                .tabItem {
                    Label("Cemaqua", systemImage: "paintbrush.fill")
                }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
