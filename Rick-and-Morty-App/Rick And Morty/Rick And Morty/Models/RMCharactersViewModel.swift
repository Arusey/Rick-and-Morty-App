//
//  RMCharactersViewModel.swift
//  Rick And Morty
//
//  Created by Kevin Lagat on 21/08/2024.
//

import Foundation
class CharactersViewModel {
    private var characters: [Character] = []
    private var currentPage = 1
    private var isLoading = false
    private let apiURL = "https://rickandmortyapi.com/api/character?page="

    var charactersUpdated: (() -> Void)?
    
    func fetchCharacters() {
        guard !isLoading else { return }
        isLoading = true

        let urlString = "\(apiURL)\(currentPage)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(CharacterResponse.self, from: data)
                    self.characters.append(contentsOf: result.results)
                    self.currentPage += 1
                    self.isLoading = false
                    DispatchQueue.main.async {
                        self.charactersUpdated?()
                    }
                } catch {
                    print(error)
                    self.isLoading = false
                }
            }
        }.resume()
    }

    func numberOfCharacters() -> Int {
        return characters.count
    }

    func character(at index: Int) -> Character {
        return characters[index]
    }

    func shouldFetchNextPage(for index: Int) {
        if index == characters.count - 1 {
            fetchCharacters()
        }
    }
}

struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let image: String
}
