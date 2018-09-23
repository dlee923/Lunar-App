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
        self.backgroundColor = .clear
        
        self.dataSource = self
        self.delegate = self
        
        registerCells()

        add_background()
    }
    
    let cell_spacing: CGFloat = 5
    let portfolio_graph_height: CGFloat = 0.246
    let stock_cell_height: CGFloat = 75
    let header_cell_height: CGFloat = 100
    
    var coins: [Crypto]? {
        didSet{
            self.reloadData()
            
            for coin in self.coins! {
//                print(coin.price_history)
//                print(coin.symbol)
            }
            
            for cell in self.visibleCells {
                if let stock_cell = cell as? DashboardStockCell {
                    stock_cell.stock_graph?.render_graph(background_clr: .clear, lineWidth: 2.0)
                }
            }
        }
    }
    
    weak var homeVC: HomeVC?
    var background_bottom_anchor: NSLayoutConstraint?
    
    // Drape a background to give continuity between dashboard and navigation bar
    func add_background() {
        let back_view = UIView()
        back_view.backgroundColor = Theme_color2
        back_view.translatesAutoresizingMaskIntoConstraints = false
        self.homeVC?.view.insertSubview(back_view, belowSubview: self)
        
        guard let home_VC = homeVC else { return }
        
        back_view.topAnchor.constraint(equalTo: home_VC.view.topAnchor, constant: 0).isActive = true
        back_view.leadingAnchor.constraint(equalTo: home_VC.view.leadingAnchor).isActive = true
        back_view.trailingAnchor.constraint(equalTo: home_VC.view.trailingAnchor).isActive = true
        background_bottom_anchor = back_view.bottomAnchor.constraint(equalTo: home_VC.home_dashboard.topAnchor)
        background_bottom_anchor?.isActive = true
    }
    
    // Use didScroll to manage background drape of portfolio graph
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = -scrollView.contentOffset.y + 87
        if offset > 0 {
            background_bottom_anchor?.constant = offset
        }
    }
    
    func registerCells() {
        self.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        self.register(DashboardStockCell.self, forCellWithReuseIdentifier: "DashboardStockCell")
        self.register(DashboardPortfolioCell.self, forCellWithReuseIdentifier: "DashboardPortfolioCell")
        self.register(DashboardHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DashboardHeaderCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1{
            return 1
        } else if section == 2{
            return coins?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cell_spacing * 2
    }
    
    
    // MARK: Content Cells
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardPortfolioCell", for: indexPath) as? DashboardPortfolioCell {
                return cell
            }
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            let watchlistView = WatchlistView()
            cell.addSubview(watchlistView)
            watchlistView.translatesAutoresizingMaskIntoConstraints = false
            watchlistView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            watchlistView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            watchlistView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            watchlistView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            return cell
        } else if indexPath.section == 2 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardStockCell", for: indexPath) as? DashboardStockCell {
                cell.crypto = coins?[indexPath.item]
                cell.set_up_stock_cell()
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat?
        var height: CGFloat?
        
        if indexPath.section == 0 {
            width = self.frame.width
            height = portfolio_graph_height * (self.homeVC?.view.frame.height ?? 0)
        } else if indexPath.section == 1 {
            width = self.frame.width
            height = stock_cell_height * 1.25
        } else if indexPath.section == 2 {
            width = (self.frame.width) - (cell_spacing * 4)
            height = stock_cell_height
        }
        
        return CGSize(width: width ?? 0, height: height ?? 0)
    }
    

    // MARK: Header Cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: self.frame.width, height: header_cell_height)
        } else if section == 2 {
            return CGSize(width: self.frame.width, height: header_cell_height / 2)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            if let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DashboardHeaderCell", for: indexPath) as? DashboardHeaderCell {
                cell.set_up(header_title: "W a t c h l i s t")
                return cell
            }
        } else if indexPath.section == 2 {
            if let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DashboardHeaderCell", for: indexPath) as? DashboardHeaderCell {
                cell.set_up(header_title: "P o s i t i o n s")
                return cell
            }
        }
        
        return UICollectionViewCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}



