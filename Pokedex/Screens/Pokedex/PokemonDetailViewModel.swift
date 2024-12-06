import Foundation

// NOTE: Un ViewModel peut simplifier le code
class PokemonDetailViewModel: ObservableObject {
	private var details : Details? = nil
	private let service = PokedexService()
	
	func getDetails(id : Int) async -> Details {
		return await service.fetchDetails(id: id)!
	}
	func getDetails(name : String) async -> Details {
		await service.fetchDetails(name: name)!
	}
	
	func localizedMenu(menu : DetailMenu)-> String{
		return service.localizedMenu(for: menu)
	}
	func formatMultiplier(mult: Double) -> String {
		switch mult {
		case ..<1:
			return "1/2"
		case 1:
			return ""
		case 1...:
			return "2"
		default:
			return ""
		}

	}
	
	func getEvolution(evolutions : [String], id : Int) async -> [Pokemon] {
		var result : [Pokemon] = []
		for evolution in evolutions{
			let p : Pokemon = await service.fetchEvolution(
				evolution: evolution
			)
			if isNotDetailedPokemon(evolution: p.id, id: id){
				result.append(p)
			}
		}
		return result
	}
	
	func isNotDetailedPokemon(evolution : Int, id : Int) -> Bool{
		return id != evolution
	}
}
