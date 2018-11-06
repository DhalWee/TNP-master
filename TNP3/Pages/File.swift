////
////  MainController.swift
////  TNP3
////
////  Created by alisher toleberdyyev on 10/28/18.
////  Copyright © 2018 alisher toleberdyyev. All rights reserved.
////
//
//import Foundation
//import SideMenu
//import UIKit
//import GoogleMaps
//import GooglePlaces
//import SnapKit
//import Alamofire
//import SwiftyJSON
//
//struct menuItem {
//    var icon_name:String!
//    var title: String!
//    var vw: UIViewController?
//}
//
//class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    var sidemenuToggled:Bool = false
//    var menuBtn: UIButton = {
//        var btn = UIButton(type: UIButton.ButtonType.custom)
//        btn.tintColor = UIColor.blueDefault
//        btn.setImage(UIImage(named: "menu"), for: .normal)
//        btn.backgroundColor = UIColor.white
//        btn.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        btn.addTarget(self, action: #selector(toggleSidemenu), for: .touchUpInside)
//        return btn
//    }()
//    
//    let WrapperView:UIView = {
//        let view = UIView(frame: CGRect.zero)
//        return view
//    }()
//    
//    var locationManager = CLLocationManager()
//    var currentLocation: CLLocation?
//    
//    var mapView: GMSMapView!
//    var placesClient: GMSPlacesClient!
//    var zoomLevel: Float = 15.0
//    var isFirstMapUpdate = true
//    
//    var myLocation: CLLocation = CLLocation()
//    var myMarker: GMSMarker = GMSMarker()
//    var myCamera: GMSCameraPosition = GMSCameraPosition()
//    var selectedParkingPlace: CLLocationCoordinate2D = CLLocationCoordinate2D()
//    
//    // An array to hold the list of likely places.
//    var likelyPlaces: [GMSPlace] = []
//    
//    // The currently selected place.
//    var selectedPlace: GMSPlace?
//    
//    var parkingPlaces: [CLLocationCoordinate2D] = [CLLocationCoordinate2D(latitude: 37.329398, longitude: -122.031365),
//                                                   CLLocationCoordinate2D(latitude: 37.323356421896314, longitude: -122.03960862010717),
//                                                   CLLocationCoordinate2D(latitude: 37.343130655841115, longitude: -122.04149689525366),
//                                                   CLLocationCoordinate2D(latitude: 37.36270915060124, longitude: -122.05338377505541)]
//    
//    var sideMenuTable: UITableView = UITableView(frame: CGRect.zero)
//    private let myArray: NSArray =  [
//        menuItem(icon_name: "menu", title: "Profile", vw: ProfileViewController()),
//        menuItem(icon_name: "menu", title: "Find Parking", vw: nil),
//        menuItem(icon_name: "menu", title: "Report Parking", vw: nil),
//        menuItem(icon_name: "menu", title: "Logout", vw: nil),
//        ]
//    
//    //=================================================== HOOKS =======================
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupNavBar()
//        self.view.backgroundColor = UIColor.white
//        self.navigationItem.title = "MAP"
//        
//        self.setupSideMenu()
//        self.setupWrapper()
//        //        self.setupGoogleMap()
//        self.setupMenuBtn()
//        
//        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: myCamera)
//        mapView.camera = myCamera
//        myMarker.iconView = setMyMarkerView()
//        myMarker.map = mapView
//        mapView.delegate = self
//        mapView.translatesAutoresizingMaskIntoConstraints = false
//        self.WrapperView.addSubview(mapView)
//        mapView.snp.makeConstraints { (make) in
//            make.edges.equalTo(self.WrapperView)
//        }
//        putMarks()
//        
//        locationManager = CLLocationManager()
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.distanceFilter = 50
//        locationManager.startUpdatingLocation()
//        locationManager.delegate = self
//        
//        placesClient = GMSPlacesClient.shared()
//        
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
//    }
//    
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.isNavigationBarHidden = false
//    }
//    
//    
//    //=================================================== SETUPS =======================
//    
//    func setupWrapper()  {
//        self.view.addSubview(WrapperView)
//        self.WrapperView.snp.makeConstraints({ (make) in
//            make.edges.equalToSuperview()
//        })
//    }
//    
//    func setupMenuBtn()  {
//        self.WrapperView.addSubview(menuBtn)
//        self.menuBtn.snp.makeConstraints({ (make) in
//            make.top.equalTo(self.WrapperView.snp.top).offset(50)
//            make.left.equalTo(self.WrapperView.snp.left).offset(20)
//            make.width.equalTo(60)
//            make.height.equalTo(60)
//        })
//        self.menuBtn.layer.cornerRadius = 30
//    }
//    
//    func setupNavBar()  {
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController!.view.backgroundColor = UIColor.clear
//        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
//    }
//    
//    func setupSideMenu()  {
//        self.view.addSubview(sideMenuTable)
//        self.sideMenuTable.snp.makeConstraints { (make) in
//            make.left.equalToSuperview()
//            make.right.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.top.equalToSuperview().offset(100)
//        }
//        self.sideMenuTable.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//        self.sideMenuTable.separatorStyle = .none
//        self.sideMenuTable.dataSource = self
//        self.sideMenuTable.delegate = self
//    }
//    
//    //=================================================== TOGGLES =======================
//    
//    @objc func toggleSidemenu(sender: UIButton!) {
//        let width = self.WrapperView.frame.width
//        let height = self.WrapperView.frame.height
//        if (self.sidemenuToggled) {
//            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseOut, animations: {
//                self.WrapperView.frame = CGRect(x: 0, y: 0, width: width, height: height)
//            }, completion: nil)
//            
//        } else {
//            UIView.animate(withDuration: 0.15, delay: 0.0, options: .curveEaseIn, animations: {
//                self.WrapperView.frame = CGRect(x: 250, y: 0, width: width, height: height)
//            }, completion: nil)
//            self.view.setNeedsDisplay()
//        }
//        self.sidemenuToggled = !self.sidemenuToggled
//        print(self.sidemenuToggled)
//    }
//    
//    //=================================================== TABLE OVERIDES =======================
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        let item = (myArray[indexPath.row] as! menuItem).vw
//        if (item != nil) {
//            self.navigationController?.show(item as! UIViewController, sender: nil)
//        }
//        print("Value: \(myArray[indexPath.row])")
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as UITableViewCell
//        cell.textLabel?.text = (myArray[indexPath.row] as! menuItem).title
//        //        cell.menu_title.text = (myArray[indexPath.row] as! menuItem).title
//        //        cell.menu_icon.image = UIImage(named: (myArray[indexPath.row] as! menuItem).icon_name)
//        return cell
//    }
//    
//}
//
//
////Functions
//extension MainController {
//    func setNewMarkerView(color: UIColor, label: String) -> UIView {
//        
//        let backView: UIView = {
//            let bv = UIView()
//            bv.layer.cornerRadius = 25
//            bv.layer.masksToBounds = true
//            return bv
//        }()
//        
//        backView.snp.makeConstraints { (make) in
//            make.height.equalTo(50)
//            make.width.equalTo(50)
//        }
//        
//        let viewShadow: UIView = {
//            let bv = UIView()
//            bv.layer.cornerRadius = 25
//            bv.layer.masksToBounds = true
//            bv.alpha = 0.4
//            bv.backgroundColor = color
//            return bv
//        }()
//        
//        let view2: UIView = {
//            let bv = UIView()
//            bv.layer.cornerRadius = 20
//            bv.layer.masksToBounds = true
//            bv.backgroundColor = color
//            return bv
//        }()
//        
//        let markerLbl: UILabel = {
//            let lbl = UILabel()
//            lbl.text = label
//            lbl.textColor = UIColor.white
//            lbl.font = UIFont.systemFont(ofSize: 20)
//            return lbl
//        }()
//        
//        
//        backView.addSubview(viewShadow)
//        backView.addSubview(view2)
//        backView.addSubview(markerLbl)
//        
//        viewShadow.snp.makeConstraints { (make) in
//            make.height.equalTo(50)
//            make.width.equalTo(50)
//            make.centerX.equalTo(backView)
//            make.centerY.equalTo(backView)
//        }
//        view2.snp.makeConstraints { (make) in
//            make.height.equalTo(40)
//            make.width.equalTo(40)
//            make.centerX.equalTo(backView)
//            make.centerY.equalTo(backView)
//        }
//        markerLbl.snp.makeConstraints { (make) in
//            make.centerX.equalTo(backView)
//            make.centerY.equalTo(backView)
//        }
//        
//        return backView
//    }
//    
//    func setMyMarkerView() -> UIView {
//        
//        let backView: UIView = {
//            let bv = UIView()
//            bv.layer.cornerRadius = 18
//            bv.layer.masksToBounds = true
//            return bv
//        }()
//        
//        backView.snp.makeConstraints { (make) in
//            make.height.equalTo(36)
//            make.width.equalTo(36)
//        }
//        
//        let viewShadow: UIView = {
//            let bv = UIView()
//            bv.layer.cornerRadius = 18
//            bv.layer.masksToBounds = true
//            bv.alpha = 0.2
//            bv.backgroundColor = UIColor(hex: blue)
//            return bv
//        }()
//        
//        let view2: UIView = {
//            let bv = UIView()
//            bv.layer.cornerRadius = 8
//            bv.layer.masksToBounds = true
//            bv.backgroundColor = UIColor(hex: blue)
//            return bv
//        }()
//        
//        
//        
//        backView.addSubview(viewShadow)
//        backView.addSubview(view2)
//        
//        viewShadow.snp.makeConstraints { (make) in
//            make.height.equalTo(36)
//            make.width.equalTo(36)
//            make.centerX.equalTo(backView)
//            make.centerY.equalTo(backView)
//        }
//        view2.snp.makeConstraints { (make) in
//            make.height.equalTo(16)
//            make.width.equalTo(16)
//            make.centerX.equalTo(backView)
//            make.centerY.equalTo(backView)
//        }
//        
//        return backView
//    }
//    
//    // Populate the array with the list of likely places.
//    func listLikelyPlaces() {
//        // Clean up from previous sessions.
//        likelyPlaces.removeAll()
//        
//        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
//            if let error = error {
//                // TODO: Handle the error.
//                print("Current Place error: \(error.localizedDescription)")
//                return
//            }
//            
//            // Get likely places and add to the list.
//            if let likelihoodList = placeLikelihoods {
//                for likelihood in likelihoodList.likelihoods {
//                    let place = likelihood.place
//                    self.likelyPlaces.append(place)
//                }
//            }
//        })
//    }
//    
//    func setNewMarker(_ markerView: UIView,_ location: CLLocation) {
//        print("MSG set new marker")
//        let marker = GMSMarker()
//        marker.iconView = markerView
//        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        marker.map = mapView
//    }
//    
//    func updateMyMarker(_ location: CLLocationCoordinate2D) {
//        print("MSG update my marker")
//        myMarker.position = location
//    }
//    
//    func putRoad(to: CLLocationCoordinate2D) {
//        //        mapView.clear()
//        //        putMarks()
//        //        setNewMarker(setMyMarkerView(), myLocation)
//        print("MSG put road")
//        let origin = "\(myLocation.coordinate.latitude),\(myLocation.coordinate.longitude)"
//        let destination = "\(to.latitude),\(to.longitude)"
//        
//        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(googleAPI)"
//        let url = URL(string: urlString)
//        
//        Alamofire.request(url!).responseJSON { (response) in
//            do {
//                print("MSG alamofire")
//                let json = try JSON(data: response.data!)
//                let routes = json["routes"].arrayValue
//                for route in routes
//                {
//                    let routeOverviewPolyline = route["overview_polyline"].dictionary
//                    let points = routeOverviewPolyline?["points"]?.stringValue
//                    let path = GMSPath.init(fromEncodedPath: points!)
//                    let polyline = GMSPolyline.init(path: path)
//                    polyline.strokeWidth = 5
//                    polyline.strokeColor = UIColor(hex: blue)
//                    polyline.map = self.mapView
//                    print(polyline)
//                }
//            } catch let error as NSError {
//                print("MSG: json error \(error)")
//            }
//        }
//        
//    }
//    
//    func putMarks() {
//        print("MSG putMarks")
//        for i in 0..<parkingPlaces.count {
//            let coordinate = parkingPlaces[i]
//            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
//            var markerView = UIView()
//            if i < 1 {
//                markerView = setNewMarkerView(color: UIColor(hex: yellow), label: "\(i+1)")
//            } else {
//                markerView = setNewMarkerView(color: UIColor(hex: green), label: "\(i+1)")
//            }
//            setNewMarker(markerView, location)
//        }
//    }
//    
//    func updateGoogleMap(_ location: CLLocationCoordinate2D,_ isfirst: Bool) {
//        print("MSG update google map")
//        var zoom:Float = zoomLevel
//        var viewingAngle:Double = 0
//        var bearing:CLLocationDirection = CLLocationDirection(exactly: 0)!
//        
//        if isFirstMapUpdate {
//            isFirstMapUpdate = false
//            zoom = 15
//            viewingAngle = 0
//            bearing = 0
//        } else {
//            zoom = mapView.camera.zoom
//            viewingAngle = mapView.camera.viewingAngle
//            bearing = mapView.camera.bearing
//        }
//        
//        myCamera = GMSCameraPosition.camera(withLatitude: location.latitude,
//                                            longitude: location.longitude,
//                                            zoom: zoom,
//                                            bearing: bearing,
//                                            viewingAngle: viewingAngle)
//        
//        mapView.animate(to: myCamera)
//        mapView = GMSMapView.map(withFrame: view.bounds, camera: myCamera)
//        if mapView.isHidden {
//            mapView.isHidden = false
//            mapView.camera = myCamera
//        } else {
//            mapView.animate(to: myCamera)
//        }
//        putRoad(to: selectedParkingPlace)
//        
//    }
//    
//}
//
//
////Map delegation
//extension MainController: CLLocationManagerDelegate, GMSMapViewDelegate {
//    
//    // Handle incoming location events.
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        myLocation = locations.last!
//        print("Location: \(myLocation)")
//        
//        updateGoogleMap(myLocation.coordinate, isFirstMapUpdate)
//        updateMyMarker(myLocation.coordinate)
//        
//        listLikelyPlaces()
//    }
//    
//    // Handle authorization for the location manager.
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .restricted:
//            print("Location access was restricted.")
//        case .denied:
//            print("User denied access to location.")
//            // Display the map using the default location.
//            mapView.isHidden = false
//        case .notDetermined:
//            print("Location status not determined.")
//        case .authorizedAlways: fallthrough
//        case .authorizedWhenInUse:
//            print("Location status is OK.")
//        }
//    }
//    
//    // Handle location manager errors.
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        locationManager.stopUpdatingLocation()
//        print("Error: \(error)")
//    }
//    
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
//    }
//    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        if selectedParkingPlace.latitude == marker.position.latitude && selectedParkingPlace.longitude == marker.position.longitude {
//            selectedParkingPlace = CLLocationCoordinate2D()
//            //remove polyline
//        } else {
//            putRoad(to: marker.position)
//            selectedParkingPlace = marker.position
//        }
//        return true
//    }
//}
