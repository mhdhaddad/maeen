//
//  AdviceCollectionTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 7/25/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class AdviceCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var advices: [Advice] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension AdviceCollectionTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advices.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdviceCell", for: indexPath) as! AdviceCollectionViewCell
        cell.advice = advices[indexPath.row]
        return cell
    }
}
extension AdviceCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width)  - (collectionView.frame.width * 0.15), height: collectionView.bounds.height - 1)
    }
}
