//
//  LocationSearchController.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/31/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.boldSystemFont(ofSize: 16)
        return name
    }()
    
    let addressLabel: UILabel = {
        let address = UILabel()
        address.translatesAutoresizingMaskIntoConstraints = false
        address.font = UIFont.systemFont(ofSize: 12)
        return address
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameLabel)
        addSubview(addressLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            addressLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 18),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class LocationSearchController: UICollectionViewController {
    
    var items = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(LocationSearchCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.backgroundColor = .white
        performLocalSearch()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! LocationSearchCell
        cell.nameLabel.text = items[indexPath.row].name
        cell.addressLabel.text = items[indexPath.row].address()

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    private func performLocalSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Park"
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
    var selectionHandler: ((MKMapItem) -> ())?
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mapItem = items[indexPath.item]
        selectionHandler?(mapItem)
    }
}

extension LocationSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 60)
    }
}
