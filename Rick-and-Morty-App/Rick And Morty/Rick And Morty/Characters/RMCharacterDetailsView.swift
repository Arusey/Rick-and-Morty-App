//
//  RMCharacterDetailsView.swift
//  Rick And Morty
//
//  Created by Kevin Lagat on 22/08/2024.
//

import SwiftUI
struct RMCharacterDetailsView: View {
    let character: RMCharacter
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: character.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.45)
                    .cornerRadius(10)
                    .clipped()
                    .edgesIgnoringSafeArea(.horizontal)
                    .edgesIgnoringSafeArea(.vertical)
            } placeholder: {
                ProgressView()
            }
            VStack(alignment: .leading, spacing: 16) {
                Text(character.name)
                    .font(.largeTitle)
                    .padding(.top, 20)
                
                Text("Species: \(character.species)")
                    .font(.subheadline)
                    .padding(.top, 8)
                
                Text("Status: \(character.status)")
                    .font(.subheadline)
                    .padding(.top, 4)
                Text("Status: \(character.gender)")
                    .font(.subheadline)
                    .padding(.top, 4)
            }
            .padding()

            
            Spacer()
        }
        .padding()
    }
}


#Preview {
    RMCharacterDetailsView(character: RMCharacter(id: 0, name: "Rick", species: "Human", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", status: "Alive", gender: "Male"))
}
