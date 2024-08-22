//
//  Rick_And_MortyTests.swift
//  Rick And MortyTests
//
//  Created by Kevin Lagat on 21/08/2024.
//

import XCTest
@testable import Rick_And_Morty

final class Rick_And_MortyTests: XCTestCase {
    
    var viewModel: RMCharactersViewModel!
    
    override func setUpWithError() throws {
        viewModel = RMCharactersViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testInitialCharacterCountIsZero() throws {
        XCTAssertEqual(viewModel.numberOfCharacters, 0, "Initial character count should be zero.")
    }
    
    func testFetchCharacters() throws {
        // Mocking the URLSession to return a specific response
        let expectation = self.expectation(description: "Characters fetched")
        viewModel.onCharactersUpdated = {
            XCTAssertEqual(self.viewModel.numberOfCharacters, 20, "Character count should be 20 after first page fetch.")
            expectation.fulfill()
        }
        
        viewModel.fetchCharacters()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFilterCharactersAlive() throws {
        let characters = [
            RMCharacter(id: 1, name: "Rick Sanchez", species: "Human", image: "", status: "Alive", gender: "Male"),
            RMCharacter(id: 2, name: "Morty Smith", species: "Human", image: "", status: "Dead", gender: "Male"),
            RMCharacter(id: 3, name: "Birdperson", species: "Bird", image: "", status: "Alive", gender: "Male"),
            RMCharacter(id: 4, name: "Mr. Meeseeks", species: "Meeseeks", image: "", status: "unknown", gender: "Male")
        ]
        
        viewModel.characters = characters
        viewModel.filterCharacters(by: 0)
        
        XCTAssertEqual(viewModel.numberOfCharacters, 2, "There should be 2 alive characters.")
        XCTAssertEqual(viewModel.getCharacter(at: 0).name, "Rick Sanchez")
        XCTAssertEqual(viewModel.getCharacter(at: 1).name, "Birdperson")
    }
    
    func testFilterCharactersDead() throws {
        let characters = [
            RMCharacter(id: 1, name: "Rick Sanchez", species: "Human", image: "", status: "Alive", gender: "Male"),
            RMCharacter(id: 2, name: "Morty Smith", species: "Human", image: "", status: "Dead", gender: "Male"),
            RMCharacter(id: 3, name: "Birdperson", species: "Bird", image: "", status: "Alive", gender: "Male"),
            RMCharacter(id: 4, name: "Mr. Meeseeks", species: "Meeseeks", image: "", status: "unknown", gender: "Male")
        ]
        
        viewModel.characters = characters
        viewModel.filterCharacters(by: 1)
        
        XCTAssertEqual(viewModel.numberOfCharacters, 1, "There should be 1 dead character.")
        XCTAssertEqual(viewModel.getCharacter(at: 0).name, "Morty Smith")
    }
    
    func testFilterCharactersUnknown() throws {
        let characters = [
            RMCharacter(id: 1, name: "Rick Sanchez", species: "Human", image: "", status: "Alive", gender: "Male"),
            RMCharacter(id: 2, name: "Morty Smith", species: "Human", image: "", status: "Dead", gender: "Male"),
            RMCharacter(id: 3, name: "Birdperson", species: "Bird", image: "", status: "Alive", gender: "Male"),
            RMCharacter(id: 4, name: "Mr. Meeseeks", species: "Meeseeks", image: "", status: "unknown", gender: "Male")
        ]
        
        viewModel.characters = characters
        viewModel.filterCharacters(by: 2)
        
        XCTAssertEqual(viewModel.numberOfCharacters, 1, "There should be 1 unknown status character.")
        XCTAssertEqual(viewModel.getCharacter(at: 0).name, "Mr. Meeseeks")
    }
    
    func testNoFilterCharacters() throws {
        let characters = [
            RMCharacter(id: 1, name: "Rick Sanchez", species: "Human", image: "", status: "Alive", gender: "Male"),
            RMCharacter(id: 2, name: "Morty Smith", species: "Human", image: "", status: "Dead", gender: "Male"),
            RMCharacter(id: 3, name: "Birdperson", species: "Bird", image: "", status: "Alive", gender: "Male"),
            RMCharacter(id: 4, name: "Mr. Meeseeks", species: "Meeseeks", image: "", status: "unknown", gender: "Male")
        ]
        
        viewModel.characters = characters
        viewModel.filterCharacters(by: 3)
        
        XCTAssertEqual(viewModel.numberOfCharacters, 4, "All characters should be present when no filter is applied.")
    }
    
    func testShouldShowLoadMoreButton() throws {
        viewModel.characters = Array(repeating: RMCharacter(id: 1, name: "Character", species: "Human", image: "", status: "Alive", gender: "Male"), count: 20)
        
        XCTAssertTrue(viewModel.shouldShowLoadMoreButton(), "Load more button should be visible when characters count is multiple of pageSize.")
        
        viewModel.characters = Array(repeating: RMCharacter(id: 1, name: "Character", species: "Human", image: "", status: "Alive", gender: "Male"), count: 19)
        
        XCTAssertFalse(viewModel.shouldShowLoadMoreButton(), "Load more button should not be visible when characters count is not a multiple of pageSize.")
    }
    
}
