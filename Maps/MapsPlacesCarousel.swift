//
//  MapsPlacesCarousel.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/28/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit

class MapsCollectionViewCell: UICollectionViewCell {
    
    var label = UILabel()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        setupLabel()
    }
    
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MapsCollectionViewCarousel: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
 
    let layout = UICollectionViewFlowLayout()

    var item = [MKMapItem]()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: self.layout)
        
        backgroundColor = .clear
        self.layout.scrollDirection = .horizontal
        delegate = self
        dataSource = self
        translatesAutoresizingMaskIntoConstraints = false
        collectionViewLayout.collectionView?.register(MapsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MapsCollectionViewCell
//        guard let name = item[indexPath.row].name else {
//            return UICollectionViewCell()
//        }
        //cell.label.text = name
        return cell
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapsCollectionViewCarousel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return .init(width: collectionView.frame.width - 64, height: collectionView.frame.height)
       }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return .init(top: 0, left: 16, bottom: 0, right: 16)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 12
       }
}
