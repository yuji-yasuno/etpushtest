//
//  ViewController.swift
//  etpushtest
//
//  Created by 楊野 勇智 on 2015/08/20.
//  Copyright (c) 2015年 salesforce.com. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager : CLLocationManager?
    var count = 0;
    var etlocationMgr : ETLocationManager?
    @IBOutlet weak var subscriberKey: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.manager = CLLocationManager()
        self.manager!.delegate = self
        self.manager!.desiredAccuracy = kCLLocationAccuracyBest
        self.manager!.requestAlwaysAuthorization()
        
        self.etlocationMgr = ETLocationManagerProxy.sharedManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.manager!.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            println("location is available")
            println("etlocationMgr!.locationEnabled = \(self.etlocationMgr!.locationEnabled())")
            self.etlocationMgr!.startWatchingLocation()
        default:
            println("location cannot use")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if let location = locations.last as? CLLocation {
            /*
            let region = CLCircularRegion(center: location.coordinate, radius: 5, identifier: "test")
            let regions : Set<CLCircularRegion> = [region]
            self.etlocationMgr!.monitorRegions(regions)
            */
            self.etlocationMgr!.updateLocationServerWithLocation(location, forAppState: LocationUpdateAppState.Background)
        }
    }

    @IBAction func editEnd(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    @IBAction func register(sender: AnyObject) {
        if !self.subscriberKey.text.isEmpty {
            ETPush.pushManager().setSubscriberKey(self.subscriberKey.text)
            ETPush.pushManager().updateET()
        }
    }

}

