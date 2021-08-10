//
//  HomeController.swift
//  UberClone
//
//  Created by VITALIY SVIRIDOV on 10.08.2021.
//

import UIKit
import Firebase
import MapKit

//login qwe@qwe.qwe
//pass qweqwe

class HomeController: UIViewController {
    
    //MARK: - Properties
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggenIn()
        locationManager.delegate = self
//        signOut()
    }
    
    //MARK: - API
    
    func checkIfUserLoggenIn() {
        if Auth.auth().currentUser?.uid == nil {
            // not logged in
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            // logged in
            configureUI()
            locationManagerDidChangeAuthorization(locationManager)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("failed logout")
        }
    }
    
    // MARK: - Helper functions
    
    func configureUI() {
        configureMapView()
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.bounds
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
}

// MARK: - Location Services

extension HomeController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        
        case .notDetermined:
            print("notDetermined")
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied: print("restricted")
            
        case .authorizedAlways:
            print("authorizedAlways")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.requestAlwaysAuthorization()
            
        @unknown default:
            print("unknown default")
        }
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    
}
