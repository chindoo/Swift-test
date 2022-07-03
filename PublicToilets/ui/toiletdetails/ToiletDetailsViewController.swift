//
//  ToiletDetailsViewController.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 03/07/2022.
//

import UIKit
import MapKit

class ToiletDetailsViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: Properties
    
    private var toilet: Toilet?
    
    // MARK: Setup
    
    func setup(with toilet: Toilet) {
        self.toilet = toilet
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
    }
    
    // MARK: IBActions
    
    @IBAction private func openInAppleMapsButtonTapped(_ sender: Any) {
        guard let toilet = toilet else {
            return
        }

        let toiletLatitude = toilet.location.coordinate.latitude
        let toiletLongitude = toilet.location.coordinate.longitude
        
        let coordinate = CLLocationCoordinate2DMake(toiletLatitude, toiletLongitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDefault])
    }
    
    // MARK: Privates
    
    private func setupMapView() {
        guard let toilet = toilet else {
            return
        }
        
        let toiletLatitude = toilet.location.coordinate.latitude
        let toiletLongitude = toilet.location.coordinate.longitude
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: toiletLatitude, longitude: toiletLongitude)
        annotation.title = toilet.openingHours
        annotation.subtitle = toilet.address
        
        let center = CLLocationCoordinate2DMake(toiletLatitude, toiletLongitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
    }
}
