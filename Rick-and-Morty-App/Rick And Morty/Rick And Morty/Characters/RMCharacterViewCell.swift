//
//  RMCharacterViewCell.swift
//  Rick And Morty
//
//  Created by Kevin Lagat on 22/08/2024.
//

import UIKit
import SDWebImage

class RMCharacterViewCell: UITableViewCell {
    
    let colorPalette: [UIColor] = [
        UIColor(red: 0.95, green: 0.8, blue: 0.8, alpha: 0.5),
        UIColor(red: 0.8, green: 0.95, blue: 0.8, alpha: 0.5),
        UIColor(red: 0.8, green: 0.8, blue: 0.95, alpha: 0.5),
    ]
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(named: "primaryTextColor")
        return label
    }()
    
    let speciesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: "secondaryTextColor")
        return label
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(characterImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(speciesLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            characterImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            characterImageView.widthAnchor.constraint(equalToConstant: 60),
            characterImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            speciesLabel.leadingAnchor.constraint(equalTo: characterImageView.trailingAnchor, constant: 10),
            speciesLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            speciesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            speciesLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        speciesLabel.text = character.species
        if let imageURL = URL(string: character.image) {
            characterImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "placeholder"))
        }
        containerView.backgroundColor = getRandomColor()
    }
    
    private func getRandomColor() -> UIColor {
        return colorPalette.randomElement() ?? UIColor.systemGray.withAlphaComponent(0.1)
    }
}
