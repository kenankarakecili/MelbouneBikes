//
//  MapVC.swift
//  MelbourneBike
//
//  Created by Kenan Karakecili on 20/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit

class MapVC: UIViewController {
  
  @IBOutlet weak var searchField: UITextField!
  
  var mapView: GMSMapView!
  let searchView = SearchView.instanceFromNib()
  
  var filteredSpots: [BikeSpotStruct] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMap()
    prepareUI()
  }
  
  func prepareUI() {
    searchField.addImage(image: icnSearch, side: .Left)
    searchField.addTarget(self, action: #selector(textFieldTextDidChange), for: UIControlEvents.editingChanged)
    searchView.delegate = self
  }
  
  func setupMap() {
    let camera = GMSCameraPosition.camera(withLatitude: melbourneCoor.latitude,
                                          longitude: melbourneCoor.longitude,
                                          zoom: 13.0)
    mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
    mapView.isMyLocationEnabled = true
    mapView.frame = CGRect(x: 0.0,
                           y: 0.0,
                           width: view.bounds.size.width,
                           height: view.bounds.size.height)
    mapView.delegate = self
    view.insertSubview(mapView, belowSubview: searchField)
    MBAPI.getSpots { (spots) in
      BikeSpot.shared.spots = spots
      for spot in spots {
        _ = self.addMarkerOnMap(spot: spot)
      }
    }
  }
  
  func addMarkerOnMap(spot: BikeSpotStruct) -> GMSMarker {
    let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: spot.coordinates.lat,
                                                            longitude: spot.coordinates.long))
    marker.title = "\(spot.featurename)"
    marker.snippet = "Available: \(spot.nbbikes)"
    marker.icon = spot.icon
    marker.map = mapView
    let circle = GMSCircle(position: marker.position, radius: 0)
    circle.strokeColor = circleColor
    circle.fillColor = circleColor
    circle.radius = CLLocationDistance(exactly: spot.nbbikes.toDouble() * 10)!
    circle.map = mapView
    return marker
  }
  
}

extension MapVC: GMSMapViewDelegate {
  
  func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    self.view.endEditing(true)
    KKPopupView.shared.dismissView()
  }
  
  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    self.view.endEditing(true)
    KKPopupView.shared.dismissView()
  }
  
  func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: marker.position))
    mapItem.name = marker.title
    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking])
  }
  
  func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
    let view = MarkerInfoView.instanceFromNib()
    view.titleLabel.text = marker.title
    return view
  }
  
}

extension MapVC: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    searchView.setup(items: BikeSpot.shared.spots.map({$0.featurename}),
                     field: searchField)
    KKPopupView.shared.showView(view: searchView)
    textFieldTextDidChange()
  }
  
  func textFieldTextDidChange() {
    let textToSearch = searchField.text?.uppercased()
    filteredSpots = BikeSpot.shared.spots.filter({$0.featurename.uppercased().contains(textToSearch!)})
    searchView.setup(items: filteredSpots.map({$0.featurename}),
                     field: searchField)
  }
  
}

extension MapVC: SearchViewDelegate {
  
  func didSelect(row: Int) {
    let selectedSpot = filteredSpots[row]
    mapView.animate(toLocation: CLLocationCoordinate2D(latitude: selectedSpot.coordinates.lat,
                                                       longitude: selectedSpot.coordinates.long))
    mapView.animate(toZoom: 18.0)
    searchField.text = selectedSpot.featurename
    mapView.clear()
    let marker = self.addMarkerOnMap(spot: selectedSpot)
    mapView.selectedMarker = marker
  }
  
}
