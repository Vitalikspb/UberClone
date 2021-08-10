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
    
    private let mapView = MKMapView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggenIn()
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
        view.addSubview(mapView)
        mapView.frame = view.bounds
    }
}
