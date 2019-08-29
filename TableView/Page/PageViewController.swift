//
//  PageViewController.swift
//  TableView
//
//  Created by Ника Перепелкина on 28/08/2019.
//  Copyright © 2019 Nika Perepelkina. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
    var headersArray = ["Записывайте", "Находите"]
    var subheadersArray = ["Записывайте свое любимое мороженое!", "Находите мороженое!"]
    var imagesArray = ["ic1", "ic2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        // загрузили первый content vc
        if let firstVC = displayViewController(atIndex: 0) {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    func displayViewController(atIndex index: Int) -> ContentViewController? {
        guard index >= 0 else { return nil }
        guard index < headersArray.count else { return nil }
        
        guard let contentVC = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? ContentViewController else { return nil }
        
        contentVC.imageFile = imagesArray[index]
        contentVC.header = headersArray[index]
        contentVC.subheader = subheadersArray[index]
        contentVC.index = index
        
        return contentVC
    }
    
    func nextVC(atIndex index: Int) {
        if let contentVC = displayViewController(atIndex: index + 1) {
            setViewControllers([contentVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
}

// листаем вперед или назад, а также функции для page controller
extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index -= 1
        return displayViewController(atIndex: index)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index += 1
        return displayViewController(atIndex: index)
    }
    
  //  func presentationCount(for pageViewController: UIPageViewController) -> Int {
  //      return headersArray.count
  //  }
  //
  //  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
  //      let contentVC = storyboard?.instantiateViewController(withIdentifier: "contentViewController") as? ContentViewController
  //      return  contentVC!.index
  //
  //  }
}
