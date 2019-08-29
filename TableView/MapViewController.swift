//
//  MapViewController.swift
//  TableView
//
//  Created by Ника Перепелкина on 24/08/2019.
//  Copyright © 2019 Nika Perepelkina. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var iceCreamStruct: IceCreammm!
    
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(iceCreamStruct.adress!) { (placemarks, error) in
            guard error == nil else {return}
            guard let placemarks = placemarks else {return}
            
            let placemark = placemarks.first!
            
            let annotation = MKPointAnnotation()
            annotation.title = self.iceCreamStruct.name
            annotation.subtitle = self.iceCreamStruct.ingredient
            
            guard let location = placemark.location else {return}
            annotation.coordinate = location.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true) // развернуть аннотацию
        }
    }
    
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil}
        
        let annotationIdentifier = "iceAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "iceAnnotation") as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
        }
        
        let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightImage.image = UIImage(data: iceCreamStruct.image! as Data)
        annotationView?.rightCalloutAccessoryView = rightImage
        
        annotationView?.pinTintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        return annotationView
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
