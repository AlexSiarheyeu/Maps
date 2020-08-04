//
//  LocationSearchCell.swift
//  Maps
//
//  Created by Alexey Sergeev on 8/2/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit

class LocationSearchCell: UICollectionViewCell {
    
    //MARK: Properties

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
    
    //MARK: Init

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
