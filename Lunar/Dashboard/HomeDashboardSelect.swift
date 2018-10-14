//
//  HomeDashboardSelect.swift
//  Lunar
//
//  Created by Daniel Lee on 10/14/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

extension HomeDashboard {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coin_vc = CoinVC()
        coin_vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        homeVC?.present(coin_vc, animated: true) {
            // pass coin info to coin_vc
        }
    }
    
}
