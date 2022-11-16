//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 06/11/2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIPageViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    // UIPageController
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    // CLLocationManager
    let manager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        
        
    // Verification de la clé
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_WEATHER_KEY") as? String
        guard let key = apiKey, !key.isEmpty else {
            print("API key does not exist")
            return
        }
        print("REST API key:", key)
        
    // Localisation
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        print(latitude)
        print(longitude)
    }
    

    

}

extension WeatherViewController {
    
    func setup(){
        dataSource = self
        delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let page1 : UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ParisViewController")
        let page2 : UIViewController! = storyboard?.instantiateViewController(withIdentifier: "NewYorkViewController")
        let page3 : UIViewController! = storyboard?.instantiateViewController(withIdentifier: "LocationViewContoller")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style(){
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func layout(){
        view.addSubview(pageControl)
    }
    
}

extension WeatherViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}


// MARK: DataSource

extension WeatherViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
}

// MARK: Dalegate

extension WeatherViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewcontrollers = pageViewController.viewControllers else {
            return
        }
        guard let currentIndex = pages.firstIndex(of: viewcontrollers[0]) else {
            return
        }
        pageControl.currentPage = currentIndex
    }
}
// MARK: - ViewControllers

//class MeteoViewController1: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}
//
//class MeteoViewController2: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}
//
//class MeteoViewController3: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//}
