
import UIKit
import GoogleMaps

class ViewController: UIViewController {
    var markerArray = [GMSMarker]()

    
    var transparentView = UIView()
    var tableView = UITableView()
    
    let height: CGFloat = 250
    
    var settingArray: [CLLocationCoordinate2D] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func loadView() {
      // Create a GMSCameraPosition that tells the map to display the
      // coordinate -33.86,151.20 at zoom level 6.
      let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
      let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
      view = mapView
      
      mapView.delegate = self
    // Create button and set didButtonClick function
      let btn: UIButton = UIButton(type: UIButton.ButtonType.roundedRect)
      btn.frame = CGRect(x: 130, y: 700, width: 200, height: 50)
      btn.setTitle("Show Markers List", for: UIControl.State.normal)
      btn.backgroundColor = UIColor(red: 0.4, green: 1.0, blue: 0.2, alpha: 0.5)
      btn.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
      self.view.addSubview(btn)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didButtonClick(_ sender: UIButton)
    {
        let window = UIApplication.shared.keyWindow
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        transparentView.frame = self.view.frame
        window?.addSubview(transparentView)
        
        let screenSize = UIScreen.main.bounds.size
        tableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: height)
        window?.addSubview(tableView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
        transparentView.addGestureRecognizer(tapGesture)
        
        transparentView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.tableView.frame = CGRect(x: 0, y: screenSize.height - self.height, width: screenSize.width, height: self.height)
        }, completion: nil)
        
        
    }
    
    @objc func onClickTransparentView() {
        let screenSize = UIScreen.main.bounds.size

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0
            self.tableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.height)
        }, completion: nil)
    }
        

}

extension ViewController: GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
//        marker.title = "Hello World"
        marker.map = mapView
        

        //When you create markers, append them to the array
        markerArray.append(marker)
        print(coordinate)
        print(markerArray)
       
        self.settingArray.append(coordinate)
        
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell else {fatalError("Unable to deque cell")}
        cell.lbl.text = "Marker \(indexPath.row+1) : \(settingArray[indexPath.row])"
        print("-----")
        print(cell.lbl.text)
//        cell.settingImage.image = UIImage(named: settingArray[indexPath.row])!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
}
