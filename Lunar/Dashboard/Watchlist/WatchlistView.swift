//
//  WatchlistView.swift
//  Lunar
//
//  Created by Daniel Lee on 9/22/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class WatchlistView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        
        registerCells()
        
        setUp()
    }
    
    var watchlist_coins: [Crypto]?
    
    func setUp() {
        self.dataSource = self
        self.delegate = self
        
        if let scroll_layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
            scroll_layout.scrollDirection = .horizontal
        }
        
        self.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        
        self.backgroundColor = .clear
    }
    
    func registerCells() {
        self.register(WatchlistCell.self, forCellWithReuseIdentifier: "watchlist_cell")
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default_cell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchlist_cell", for: indexPath) as? WatchlistCell {
            cell.crypto = watchlist_coins?[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 125, height: collectionView.frame.height)
        return size
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
