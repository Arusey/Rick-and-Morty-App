//
//  RMCharactersViewController.swift
//  Rick And Morty
//
//  Created by Kevin Lagat on 21/08/2024.
//

import UIKit
import SwiftUI

class RMCharactersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private let viewModel = RMCharactersViewModel()
    let segmentedControl = UISegmentedControl(items: ["Alive", "Dead", "Unknown"])

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Rick and Morty Characters"
        setupSegmentedControl()
        setupTableView()
        setupViewModel()
        viewModel.fetchCharacters()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RMCharacterViewCell.self, forCellReuseIdentifier: "RMCharacterViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LoadMoreCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
        
        let selectedColor = UIColor(red: 0.678, green: 0.847, blue: 0.902, alpha: 1.0) // Baby blue color (adjust as needed)
        let unselectedColor = UIColor.white
        let borderColor = UIColor.lightGray // Light gray border when unselected
        let textColor = UIColor.black // Dark text color when selected
        let unselectedTextColor = UIColor.black // Dark text color when unselected
        
        // Set text color for selected state
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor
        ]
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        // Set text color for unselected state
        let unselectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: unselectedTextColor
        ]
        segmentedControl.setTitleTextAttributes(unselectedAttributes, for: .normal)
        
        // Set background colors
        segmentedControl.setBackgroundImage(UIImage(color: selectedColor), for: .selected, barMetrics: .default)
        segmentedControl.setBackgroundImage(UIImage(color: unselectedColor), for: .normal, barMetrics: .default)
        
        // Set border
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = borderColor.cgColor
        segmentedControl.layer.cornerRadius = 25 // Make it oval, half of the height
        segmentedControl.clipsToBounds = true
        
        // Add the segmented control to the view
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50) // Set height to 50 points
        ])
    }
    
    @objc private func filterChanged(_ sender: UISegmentedControl) {
        viewModel.filterCharacters(by: sender.selectedSegmentIndex)
    }
    
    private func setupViewModel() {
        viewModel.onCharactersUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCharacters + (viewModel.shouldShowLoadMoreButton() ? 1 : 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < viewModel.numberOfCharacters {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RMCharacterViewCell", for: indexPath) as! RMCharacterViewCell
            let character = viewModel.getCharacter(at: indexPath.row)
            cell.configure(with: character)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell", for: indexPath)
            cell.textLabel?.text = "Load More"
            cell.textLabel?.textAlignment = .center
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < viewModel.numberOfCharacters {
            let character = viewModel.getCharacter(at: indexPath.row)
            let characterDetailView = RMCharacterDetailsView(character: character)
            let hostingController = UIHostingController(rootView: characterDetailView)
            navigationController?.pushViewController(hostingController, animated: true)
        } else {
            viewModel.fetchCharacters()
        }
    }

}
