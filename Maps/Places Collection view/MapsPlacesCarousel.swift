//
//  MapsPlacesCarousel.swift
//  Maps
//
//  Created by Alexey Sergeev on 7/28/20.
//  Copyright © 2020 Alexey Sergeev. All rights reserved.
//

import UIKit
import MapKit

class MapsCollectionViewCarousel: UICollectionView, UICollectionViewDelegate {
 
    let layout = UICollectionViewFlowLayout()
    var items = [MKMapItem]() 
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: self.layout)
        
        backgroundColor = .clear
        self.layout.scrollDirection = .horizontal
        
        delegate = self
        dataSource = self
        
        translatesAutoresizingMaskIntoConstraints = false
        collectionViewLayout
            .collectionView?
            .register(MapsCollectionViewCell.self,
                      forCellWithReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapsCollectionViewCarousel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView
                    .dequeueReusableCell(withReuseIdentifier: "cell",
                                         for: indexPath) as! MapsCollectionViewCell
    
        cell.label.text = items[indexPath.row].name
        
        return cell
    }
}

extension MapsCollectionViewCarousel: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
           return .init(width: collectionView.frame.width - 64,
                        height: collectionView.frame.height)
       }
       
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
           return .init(top: 0, left: 16,
                        bottom: 0, right: 16)
       }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
           return 12
       }
}
