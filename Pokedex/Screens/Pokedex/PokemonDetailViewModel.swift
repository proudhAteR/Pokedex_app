import Foundation

// NOTE: Un ViewModel peut simplifier le code
class PokemonDetailViewModel: ObservableObject {
	private var details : Details? = nil
	private let service = PokedexService()
	
	func getDetails(id : Int) async -> Details {
		details = details == nil ? await service.fetchDetails(id: id)! : details
		return details!
	}
	
	func localizedMenu(menu : Menu)-> String{
		return service.localizedMenu(for: menu)
	}
}
