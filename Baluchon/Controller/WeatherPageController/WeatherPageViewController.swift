//
//  WeatherPageViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 17/11/2022.
//

import UIKit

class WeatherPageViewController: UIPageViewController {

    // MARK: - Properties
    lazy var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        style()
        layout()
    }

    // MARK: - Methods
        func setup() {
            dataSource = self
            delegate = self

            pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)

            let page1: UIViewController? = storyboard?.instantiateViewController(
                withIdentifier: "LocationViewController")as? LocationViewController
            let page2: UIViewController? = storyboard?.instantiateViewController(
                withIdentifier: "ParisViewController")as? ParisViewController
            let page3: UIViewController? = storyboard?.instantiateViewController(
                withIdentifier: "NewYorkViewController")as? NewYorkViewController

            if let page1 {
                pages.append(page1)
            }
            if let page2 {
                pages.append(page2)
            }
            if let page3 {
                pages.append(page3)
            }

            setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        }

    func style() {
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            pageControl.currentPageIndicatorTintColor = .white
            pageControl.pageIndicatorTintColor = .systemGray4
            pageControl.numberOfPages = pages.count
            pageControl.currentPage = initialPage
            pageControl.setIndicatorImage(UIImage(systemName: "location.fill"), forPage: 0)
        }

        func layout() {
            view.frame = self.view.bounds
            view.addSubview(pageControl)

            NSLayoutConstraint.activate([
                        pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
                        pageControl.heightAnchor.constraint(equalToConstant: 200),
                        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                            constant: 75)
            ])
        }

    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
//    extension WeatherPageViewController {
        @objc func pageControlTapped(_ sender: UIPageControl) {
            setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        }
    }

    // MARK: - DataSource
    extension WeatherPageViewController: UIPageViewControllerDataSource {

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
            if currentIndex == 0 {
                return pages.last                   // wrap to last
            } else {
                return pages[currentIndex - 1]      // go previous
            }
        }

        func pageViewController(_ pageViewController: UIPageViewController,
                                viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let currentIndex = pages.firstIndex(of: viewController) else {return nil}
            if currentIndex < pages.count - 1 {
                return pages[currentIndex + 1]      // go next
            } else {
                return pages.first                  // wrap to first
            }
        }
    }

    // MARK: - Dalegate
    extension WeatherPageViewController: UIPageViewControllerDelegate {

        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool,
                                previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            guard let viewcontrollers = pageViewController.viewControllers else {
                return
            }
            guard let currentIndex = pages.firstIndex(of: viewcontrollers[0]) else {
                return
            }
            pageControl.currentPage = currentIndex
        }
    }
