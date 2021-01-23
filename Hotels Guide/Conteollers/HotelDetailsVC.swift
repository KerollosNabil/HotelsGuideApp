//
//  HotelDetailsVC.swift
//  Hotels Guide
//
//  Created by MAC on 22/01/2021.
//

import UIKit
import MapKit

class HotelDetailsVC: UIViewController {
    
    var hotel:HotelGuide!
    
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelAdressLabel: UILabel!
    @IBOutlet weak var lowRateLabel: UILabel!
    @IBOutlet weak var highRateLabel: UILabel!
    private let fullScreenImageViewer = UIView()
    private let fullScreenImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewElements()
        setupHotelImageTabGesture()
        setupFullScreenImageView()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupHotelLocation()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        fullScreenImageViewer.frame = view.bounds.insetBy(dx: 0, dy: self.view.safeAreaInsets.top/2).offsetBy(dx: 0, dy: self.view.safeAreaInsets.top/2)
        fullScreenImageView.frame = fullScreenImageViewer.bounds
    }
    private func setupViewElements(){
        hotelImage.image = hotel.image
        hotelNameLabel.text = hotel.hotelSummary.hotelName
        hotelAdressLabel.text = hotel.location.address
        highRateLabel.text = "High Rate: \(hotel.hotelSummary.highRate)"
        lowRateLabel.text = "Low Rate: \(hotel.hotelSummary.lowRate)"
    }
    private func setupHotelLocation(){
        map.delegate = self
        let hotelLocation = MKPointAnnotation()
        hotelLocation.title = hotel.hotelSummary.hotelName
        hotelLocation.coordinate = CLLocationCoordinate2D(latitude: hotel.location.latitude, longitude: hotel.location.longitude)
        map.addAnnotation(hotelLocation)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: hotel.location.latitude, longitude: hotel.location.longitude), latitudinalMeters: 5000, longitudinalMeters: 5000)
        map.setRegion(region, animated: true)
    }
    
    private func setupFullScreenImageView(){
        view.addSubview(fullScreenImageViewer)
        fullScreenImageViewer.addSubview(fullScreenImageView)
        
        fullScreenImageViewer.frame = view.bounds
        fullScreenImageViewer.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        fullScreenImageViewer.alpha = 0
        
        fullScreenImageView.contentMode = .scaleAspectFit
        setupFullScreenHotelImageTabGesture()
        
    }
    
    
    private func setupFullScreenHotelImageTabGesture(){
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(hideFullScreenImage))
        fullScreenImageViewer.addGestureRecognizer(tapGest)
    }
    
    private func setupHotelImageTabGesture(){
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(showFullScreenImage))
        hotelImage.isUserInteractionEnabled = true
        hotelImage.addGestureRecognizer(tapGest)
    }
    @objc private func hideFullScreenImage(){
        UIView.animate(withDuration: 0.5, delay: 0, options: []) {[weak self] in
            guard let self = self else{return}
            self.fullScreenImageViewer.alpha = 0
            self.fullScreenImageViewer.frame = self.hotelImage.frame
            self.fullScreenImageView.frame = self.fullScreenImageViewer.bounds
            
        }
    }
    @objc private func showFullScreenImage(){
        fullScreenImageView.image = hotelImage.image
        fullScreenImageViewer.frame = hotelImage.frame
        fullScreenImageView.frame = fullScreenImageViewer.bounds
        
        UIView.animate(withDuration: 0.5, delay: 0, options: []) {[weak self] in
            guard let self = self else{return}
            self.fullScreenImageViewer.alpha = 1
            self.fullScreenImageViewer.frame = self.view.bounds.insetBy(dx: 0, dy: self.view.safeAreaInsets.top/2).offsetBy(dx: 0, dy: self.view.safeAreaInsets.top/2)
            self.fullScreenImageView.frame = self.fullScreenImageViewer.bounds
            
        }
    }
}
extension HotelDetailsVC:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
