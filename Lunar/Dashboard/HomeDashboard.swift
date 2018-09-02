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
        self.backgroundColor = home_dashboard_color
        self.dataSource = self
        self.delegate = self
        
        registerCells()
    }
    
    var coins: [Crypto]? {
        didSet{
            self.reloadData()
            
            for coin in self.coins! {
//                print(coin.price_history)
//                print(coin.symbol)
            }
            
            for cell in self.visibleCells {
                if let stock_cell = cell as? DashboardStockCell {
                    stock_cell.stock_graph?.render_graph(background_clr: .clear)
                }
            }
        }
    }
    
    weak var homeVC: HomeVC?
    
    let cell_spacing: CGFloat = 5
    
    func registerCells() {
        self.register(DashboardStockCell.self, forCellWithReuseIdentifier: "DashboardStockCell")
        self.register(DashboardPortfolioCell.self, forCellWithReuseIdentifier: "DashboardPortfolioCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return coins?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat?
        var height: CGFloat?

        if indexPath.section == 0 {
            width = self.frame.width
            height = 200
        } else if indexPath.section == 1 {
            width = ((self.frame.width) / 2) - (cell_spacing / 2)
            height = (width ?? 0) / 2
        }
        
        return CGSize(width: width ?? 0, height: height ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cell_spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardPortfolioCell", for: indexPath) as? DashboardPortfolioCell {
                return cell
            }
        } else if indexPath.section == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardStockCell", for: indexPath) as? DashboardStockCell {
                cell.crypto = coins?[indexPath.item]
                cell.set_up_stock_cell()
                return cell
            }
        }
        
        return UICollectionViewCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}



