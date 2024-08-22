//
//  RMCharactersViewModel.swift
//  Rick And Morty
//
//  Created by Kevin Lagat on 21/08/2024.
//

import Foundation
class RMCharactersViewModel {
    
    private var characters: [Character] = []
    private var page = 1
    private let pageSize = 20
    var isLoading = false
    private var filteredCharacters: [Character] = []
    private var currentFilter: Status?
    
    
    enum Status {
        case alive
        case dead
        case unknown
    }
    
    var onCharactersUpdated: (() -> Void)?
    
    func fetchCharacters() {
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "https://rickandmortyapi.com/api/character/?page=\(page)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            self.isLoading = false
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    self.characters.append(contentsOf: result.results)
                    self.page += 1
                    
                    if self.currentFilter == nil {
                        DispatchQueue.main.async {
                            self.onCharactersUpdated?()
                        }
                    } else {
                        self.applyFilter()
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    var numberOfCharacters: Int {
        return filteredCharacters.isEmpty && currentFilter == nil ? characters.count : filteredCharacters.count
    }
    
    func getCharacter(at index: Int) -> Character {
        return filteredCharacters.isEmpty && currentFilter == nil ? characters[index] : filteredCharacters[index]
    }
    
    func shouldShowLoadMoreButton() -> Bool {
        return characters.count % pageSize == 0
    }
    
    func filterCharacters(by index: Int) {
        switch index {
        case 0: currentFilter = .alive
        case 1: currentFilter = .dead
        case 2: currentFilter = .unknown
        default: currentFilter = nil
        }
        applyFilter()
    }
    
    private func applyFilter() {
        guard let currentFilter = currentFilter else { return }
        
        switch currentFilter {
        case .alive:
            filteredCharacters = characters.filter { $0.status == "Alive" }
        case .dead:
            filteredCharacters = characters.filter { $0.status == "Dead" }
        case .unknown:
            filteredCharacters = characters.filter { $0.status == "unknown" }
        }
        
        DispatchQueue.main.async {
            self.onCharactersUpdated?()
        }
    }
    
    func getFilteredCharacter(at index: Int) -> Character {
        return filteredCharacters[index]
    }
}

struct CharacterResponse: Codable {
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let species: String
    let image: String
    let status: String
}
