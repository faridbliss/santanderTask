//
//  HomeView.swift
//  SantanderTask
//
//  Created by Farid Ullah on 17/12/2020.
//

import Foundation
import UIKit
import Base

class HomeView: BaseView {
    let refreshControl = UIRefreshControl()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width/2.5 , height: width/2.5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()

    override func setupSubviews() {
        collectionView.register(HomeCollectionCell.self, forCellWithReuseIdentifier: HomeCollectionCell.identifier)

    }
    override func addSubviews() {
        super.addSubviews()
        addSubview(collectionView)
        collectionView.addSubview(refreshControl)

    }
    override func setupAutoLayout() {
        super.setupAutoLayout()

        collectionView.snp.makeConstraints {make in
            make.top.equalTo(self).offset(100)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(-20)
            make.bottom.equalTo(self).offset(0)
        }
    }

}
