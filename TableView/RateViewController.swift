//
//  RateViewController.swift
//  TableView
//
//  Created by Ника Перепелкина on 24/08/2019.
//  Copyright © 2019 Nika Perepelkina. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {
    
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    var iceCreamRating : String?
    
    @IBAction func rateIceCream(sender: UIButton) {
        switch sender.tag {
        case 0: iceCreamRating = "up"
        case 1: iceCreamRating = "down"
        default: break
        }
        
        performSegue(withIdentifier: "unvindSegueToICD", sender: sender)
    }
    
    
    // анимация
    override func viewDidAppear(_ animated: Bool) {
//        UIView.animate(withDuration: 0.5) {
//            self.ratingStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }
        
        let buttonArray = [upButton, downButton]
        
        for (index, button) in buttonArray.enumerated() {
            let delay = Double(index) * 0.2
            UIView.animate(withDuration: 0.6, delay: delay, usingSpringWithDamping: 0.5, initialSpringVelocity: 0,  options: .curveEaseInOut, animations: {
                button?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        }
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // ratingStackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
         upButton.transform = CGAffineTransform(scaleX: 0, y: 0)
         downButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        
        
        // размытие фона
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 1)
        
        
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
