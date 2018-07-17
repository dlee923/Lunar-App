//
//  HomeDashboard.swift
//  Lunar
//
//  Created by Daniel Lee on 7/11/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class HomeDashboard: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewFlowLayout())
        self.backgroundColor = .gray
        self.dataSource = self
    }
    
    var coins: [Crypto]? {
        didSet{
            print("dashboard coins set")
            self.reloadData()
        }
    }
    
    func registerCells() {
        self.register(DashboardGraphCell.self, forCellWithReuseIdentifier: "DashboardCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCell", for: indexPath) as? DashboardGraphCell {
            return cell
        }
        
        return UICollectionViewCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}



