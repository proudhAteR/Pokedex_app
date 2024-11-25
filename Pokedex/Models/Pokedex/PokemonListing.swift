import Foundation

// Le code de base est fourni, mais il doit être modifier.
//
//  1. Utiliser https://app.quicktype.io/ pour générer les structs de selon les différents JSON
//  2. Générer le CodingKeys pour renommer les champs qui ont un nom différent dans le JSON
//  3. Ajouter les protocoles nécessaires pour l'encodage/décodage JSON, l'utilisation des structs dans un ForEach, etc.
//  4. Assurez-vous de bien séparer les différentes structs dans différents fichiers et de ne pas tout mettre dans le même fichier.
//
// NOTE: Il est également possible de mettre les différentes paramètres dans QuickType pour générer le tout comme il faut.
//
struct PokemonListing : Decodable{
    let results: [Pokemon]
}


