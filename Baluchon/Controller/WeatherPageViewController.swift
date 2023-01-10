//
//  WeatherPageViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 17/11/2022.
//

import UIKit

class WeatherPageViewController: UIPageViewController {
    // MARK: - Properties
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        style()
        layout()
        
    }
}
    extension WeatherPageViewController {
        
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
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.currentPageIndicatorTintColor = .white
            pageControl.pageIndicatorTintColor = .systemGray4
            pageControl.numberOfPages = pages.count
            pageControl.currentPage = initialPage
        }
        
        func layout(){
            view.addSubview(pageControl)
            
            NSLayoutConstraint.activate([
                        pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
                        pageControl.heightAnchor.constraint(equalToConstant: 200),
                        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 75)
            ])
            

        }
        
    }

    extension WeatherPageViewController {
        @objc func pageControlTapped(_ sender: UIPageControl) {
            setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        }
    }


    // MARK: DataSource

    extension WeatherPageViewController: UIPageViewControllerDataSource {
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

    extension WeatherPageViewController: UIPageViewControllerDelegate {
        
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
