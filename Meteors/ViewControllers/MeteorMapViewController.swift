//
//  MeteorMapViewController.swift
//  Meteors
//
//  Created by Tony on 19/02/2020.
//  Copyright © 2020 Tony M Joseph. All rights reserved.
//

import UIKit
import MapKit

class MeteorMapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var meteorMapView: MKMapView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var meteor: Meteor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAnnotation()
        setUpDisplay()
    }
    
    func setUpDisplay() {
        nameLabel.text = meteor?.name
        if let mass = meteor?.mass {
            massLabel.text = Utilities().labelTextForMass(mass)
        }
        yearLabel.text = String(Utilities().yearFromString(meteor?.year ?? Constants.apiDefaultYear))
    }
    
    func addAnnotation() {
        
        let annotation = MKPointAnnotation()
        annotation.title = meteor?.name
        
        if let latitude = Double((meteor?.reclat)!), let longitude = Double((meteor?.reclong)!) {
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }

        meteorMapView.addAnnotation(annotation)
        meteorMapView.showAnnotations(meteorMapView.annotations, animated: true)
        meteorMapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180))
        
        meteorMapView.setRegion(region, animated: true)
    }
}
