import SwiftUI

struct PokemonUpgradesView: View {
	@Binding var details : Details
	let pokemon : Pokemon
    var body: some View {
		Text("\($details)")
    }
}
