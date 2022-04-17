//
//  UserListViewController.swift
//  SuitmediaApp
//
//  Created by Gilang Ramdhani Putra on 17/04/22.
//

import UIKit
import MapKit

class UserListViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var imageIcon: UIBarButtonItem!
    @IBOutlet weak var usersTableView: UITableView!
    var apiService = ApiService()
    var pointAnnotation:CustomPointAnnotation!
    private var viewModel = UsersViewModel()
    let refreshControl = UIRefreshControl()
    var perPageData = 10
    var iconMapPressed = false
    var simpanNama : [Data] = [Data]()
    
    let latLng = [
        ["latitude" : -6.297805, "longitude" : 106.816521],
        ["latitude" : -6.326323, "longitude" : 106.529603],
        ["latitude" : -6.128266, "longitude" : 106.225799],
        ["latitude" : -6.188675, "longitude" : 106.664615],
        ["latitude" : -6.604631, "longitude" : 106.516093],
        ["latitude" : -6.389986, "longitude" : 106.364195],
        ["latitude" : -6.716021, "longitude" : 106.733554],
        ["latitude" : -6.661630, "longitude" : 106.914402],
        ["latitude" : -6.480755, "longitude" : 106.475176],
        ["latitude" : -6.047711, "longitude" : 106.374321],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.register(UsersTableViewCell.nib(), forCellReuseIdentifier: UsersTableViewCell.identifier )
        let attr = [NSAttributedString.Key.foregroundColor:UIColor.black]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attr)
        refreshControl.backgroundColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        usersTableView.addSubview(refreshControl)
        usersTableView.delegate = self
        usersTableView.dataSource = self
        mapView.delegate = self

        retrieveData(page: 1, per_page: 10)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -6.297805, longitude: 106.816521), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        mapView.setRegion(region, animated: true)
            }
    
    @objc func refresh(_ sender: AnyObject) {

        perPageData = perPageData + 10
        retrieveData(page: 1, per_page: perPageData)
        refreshControl.endRefreshing()
    }
    
    private func retrieveData(page: Int, per_page : Int ) {
        viewModel.fetchUserData(page: page, per_page: per_page) { _ in
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
        }
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func iconPressed(_ sender: Any) {
        
        if iconMapPressed == false {
            imageIcon.image = UIImage(systemName: "list.dash")
            iconMapPressed = true
            mapView.isHidden = false
            usersTableView.isHidden = true
        }else{
            imageIcon.image = UIImage(named: "Exclude")
            iconMapPressed = false
            mapView.isHidden = true
            usersTableView.isHidden = false

        }
    }
    
}


extension UserListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = usersTableView.dequeueReusableCell(withIdentifier: UsersTableViewCell.identifier, for: indexPath) as! UsersTableViewCell
        let game = viewModel.cellForRowAt(indexPath: indexPath)
        
        var counter = 0
            var allLocations = [MKPointAnnotation]()
            for location in self.latLng {
                pointAnnotation = CustomPointAnnotation()
                pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: (location["latitude"] ?? 0.0) as Double, longitude: (location["longitude"] ?? 0.0) as Double)
                
                pointAnnotation.title = "\(viewModel.users[counter].firstName) \(viewModel.users[counter].lastName)"
                pointAnnotation.subtitle = viewModel.users[counter].email
                pointAnnotation.pinCustomImageName = viewModel.users[counter].avatar
                    
                allLocations.append(pointAnnotation)
                counter = counter + 1
            }
        
        print("semua lokasi \(allLocations)")
        
        mapView.addAnnotations(allLocations as [MKAnnotation])
        mapView.showAnnotations(mapView.annotations, animated: true)

        customCell.configure(dataUsers: game)
        return customCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = viewModel.cellForRowAt(indexPath: indexPath)
        
        let dataUser:[String: String] = ["firstName": game.firstName, "lastName" : game.lastName, "emailUser" : game.email, "imageProfile" : game.avatar]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil, userInfo: dataUser)

        dismiss(animated: true, completion: nil)
    }
    
    
}

extension UserListViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let storyboard = UIStoryboard(name: "BottomSheet", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "bottomSheet") as! BottomSheetViewController
          
          if let presentationController = viewController.presentationController as? UISheetPresentationController {
              presentationController.detents = [.medium()] /// change to [.medium(), .large()] for a half *and* full screen sheet
          }
        
        pointAnnotation = CustomPointAnnotation()
        
        var titleSend  = ""
        var emailSend = ""
        if let optionalTitle = view.annotation?.title, let title = optionalTitle {
            titleSend = title
        }
        
        if let optionalTitleEmail = view.annotation?.subtitle, let subtitle = optionalTitleEmail {
            emailSend = subtitle
        }
        let customPointAnnotation = view.annotation as! CustomPointAnnotation
        let imageSend = "\(customPointAnnotation.pinCustomImageName ?? "")"
        
        viewController.nama = "\(titleSend)"
        viewController.image = "\(imageSend)"
        viewController.email = "\(emailSend)"
          
          self.present(viewController, animated: true)

    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {

    }
    
}
