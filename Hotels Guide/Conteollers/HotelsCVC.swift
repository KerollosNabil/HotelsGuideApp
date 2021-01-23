//
//  HotelsCVC.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import UIKit


class HotelsCVC: UICollectionViewController {
    
    var hotels = [HotelGuide]()

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
                HotelGuideBuilder.build(hotels:hotels.hotels){ hotelGuide in
                    self.hotels.append(hotelGuide)
                    self.collectionView.reloadData()
                    if let layout = self.collectionView.collectionViewLayout as? GridLayout{
                        layout.updateLayout()
                    }
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
    func collectionView(_ collectionView: UICollectionView, cellWidth: CGFloat, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let imageSize = hotels[indexPath.item].image.size
        return imageSize.height * (cellWidth / imageSize.width)
    }
    
  
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView.reloadData()
        if let layout = self.collectionView.collectionViewLayout as? GridLayout{
            layout.updateLayout()
        }

    }
}

