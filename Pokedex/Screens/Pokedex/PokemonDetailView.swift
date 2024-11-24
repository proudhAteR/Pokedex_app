import SwiftUI

//
// Je recommande fortement l'utilisation de LazyVGrid pour placer des éléments alignés en grid.
// C'est facile d'utilisation et cela permet de facilement placer n'importe quel élément.
//
// GeometryReader est utile pour pouvoir récupérer la taille de l'appareil et pouvoir faire un ratio pour
// une dimension. Par exemple, height*0.6 pour s'assurer que prendre 60% de la taille en tout temps.
//
// Un TabView personnalisé se fait avec l'utilisation de .tag() et une variable @State pour conserver l'état sélectionné
//  - Revoir l'exemple ChartsMVVM avec le Picker
//  - TabViewStyle peut être utile pour changer le style du TabView au besoin
//
// .clipShape() peut permettre de faire des shapes avec des coins arrondis, etc.
//
struct PokemonDetailView: View {
    var body: some View {
        Text("Écran pour le détail d'un Pokémon")
    }
}

#Preview {
    PokemonDetailView()
}
