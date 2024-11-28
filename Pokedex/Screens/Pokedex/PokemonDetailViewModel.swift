import Foundation

// NOTE: Un ViewModel peut simplifier le code
class PokemonDetailViewModel: ObservableObject {
	@Published var details : Details? = nil
	private let service = PokedexService()
	
	func getDetails(id : Int) async -> Details {
		details = details == nil ? await service.fetchDetails(id: id)! : details
		return details!
	}
}
