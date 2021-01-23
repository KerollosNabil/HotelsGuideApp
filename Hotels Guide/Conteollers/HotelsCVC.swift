//
//  HotelsCVC.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import UIKit


class HotelsCVC: UICollectionViewController {
    
    var hotels = [Hotel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        feachHotels()
        setupCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    private func setupCollectionView(){
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        if let layout = collectionView?.collectionViewLayout as? GridLayout {
          layout.delegate = self
        }

    }
    private func feachHotels(){
        let feacher = HotelFetcher()
        feacher.getHotels {[weak self] (result) in
            guard let self = self else {return}
            switch result{
            case .success(let hotels):
                self.hotels.append(contentsOf: hotels.hotels)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()

                }
            case.failure(let error):
                print(error.rawValue)
            }
        }
    }
    

}
extension HotelsCVC:UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotelCell.reuseId, for: indexPath) as! HotelCell
    
        cell.set(hotel: hotels[indexPath.item])
    
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        
      return CGSize(width: itemSize, height: itemSize)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hotelsStoryBoard = UIStoryboard(name: "Hotels", bundle: nil)
        let detailsVC = hotelsStoryBoard.instantiateViewController(identifier: "HotelDetailsVC") as! HotelDetailsVC
        detailsVC.hotel = hotels[indexPath.item]
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
extension HotelsCVC: GridLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    
    if let height = (collectionView.cellForItem(at: indexPath) as? HotelCell)?.hotelImage.image?.size.height {
        return height
    }
    
    return (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
  }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.collectionView.collectionViewLayout.invalidateLayout()

    }
}

