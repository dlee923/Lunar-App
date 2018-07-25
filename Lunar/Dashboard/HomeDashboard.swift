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
        self.delegate = self
        
        registerCells()
    }
    
    var coins: [Crypto]? {
        didSet{
            self.reloadData()
        }
    }
    
    weak var homeVC: HomeVC?
    
    func registerCells() {
        self.register(DashboardGraphCell.self, forCellWithReuseIdentifier: "DashboardCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coins?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.frame.width - 15) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCell", for: indexPath) as? DashboardGraphCell {
            cell.crypto = coins?[indexPath.item]
            cell.set_up_stock_cell()
            return cell
        }
        
        return UICollectionViewCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}



