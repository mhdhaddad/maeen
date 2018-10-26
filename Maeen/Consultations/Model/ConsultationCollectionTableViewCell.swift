//
//  ConsultationCollectionTableViewCell.swift
//  Maeen
//
//  Created by yahya alshaar on 8/5/18.
//  Copyright © 2018 yahya alshaar. All rights reserved.
//

import UIKit

class ConsultationCollectionTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var consultations: [Consultation] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
extension ConsultationCollectionTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return consultations.count > 1 ? 1: 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return consultations.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConsultationCollectionViewCell.identifier, for: indexPath) as! ConsultationCollectionViewCell
        cell.consultation = consultations[indexPath.item]
        return cell
    }
}
extension ConsultationCollectionTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width)  - (collectionView.frame.width * 0.15), height: collectionView.bounds.height - 1)
    }
}
