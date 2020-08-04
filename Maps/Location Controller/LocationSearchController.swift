//
//  LocationSearchController.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/31/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit
import Combine

class LocationSearchController: UICollectionViewController {
    
    //MARK: Properties

    var items = [MKMapItem]()
    let navBar = UIView().createNavigationBar()
    
    let searchTextField: UITextField = {
        let tf = UITextField.init(placeholder: "Search location")
        return tf
    }()
    
    //MARK: View controller lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.addSubview(navBar)
        collectionView.register(LocationSearchCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.addGestureRecognizer(UISwipeGestureRecognizer(target: self, action: #selector(dismissSearchController)))
        collectionView.backgroundColor = .white
        
        searchTextField.becomeFirstResponder()
        
        setupSearchListener()
        setupSearchNavBar()
    }
    
    //MARK: Private methods and selectors implementationn

    @objc func dismissSearchController() {
        navigationController?.popViewController(animated: true)
    }

    private func setupSearchNavBar() {
        
        navBar.addSubview(searchTextField)
        navBar.backgroundColor = .white
        
        NSLayoutConstraint.activate([
           navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           navBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
           navBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
        ])
        
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -16),
            searchTextField.topAnchor.constraint(equalTo: navBar.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTextField.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -16)
        ])
    }
    
    //MARK: - Setup Collection view
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! LocationSearchCell
        cell.nameLabel.text = items[indexPath.row].name
        cell.addressLabel.text = items[indexPath.row].address()

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    var selectionHandler: ((MKMapItem) -> ())?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mapItem = items[indexPath.item]
        selectionHandler?(mapItem)
    }
    
    var listener: AnyCancellable!
    private func setupSearchListener() {
        
        listener = NotificationCenter.default
                    .publisher(for: UITextField.textDidChangeNotification, object:  searchTextField)
                    .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                    .sink(receiveValue: { [weak self] (_) in
                            self?.performLocalSearch()
                            })
    }
    
    private func performLocalSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTextField.text
        let localSearch = MKLocalSearch(request: request)

        localSearch.start { [weak self] (response, error) in

            if let error = error {
                print(error)
                return
            }
            self?.items = response?.mapItems ?? []

            self?.collectionView.reloadData()
        }
    }
}

    //MARK: UICollectionViewDelegateFlowLayout

extension LocationSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 60)
    }
}
