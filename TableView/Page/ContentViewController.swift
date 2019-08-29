//
//  ContentViewController.swift
//  TableView
//
//  Created by Ника Перепелкина on 28/08/2019.
//  Copyright © 2019 Nika Perepelkina. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subheaderLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var pageButton: UIButton!
    
    
    var header = ""
    var subheader = ""
    var imageFile = ""
    var index = 0
    
    
    
    @IBAction func pageButtonPressed(_ sender: UIButton) {
        switch index {
        case 0:
            let pageVC = parent as! PageViewController
            pageVC.nextVC(atIndex: index)
        case 1:
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pageButton.layer.cornerRadius = 15
        pageButton.clipsToBounds = true
        pageButton.layer.borderWidth = 2 // ширина обводки
        pageButton.backgroundColor = #colorLiteral(red: 0.9243425727, green: 0.6394632459, blue: 0.909599185, alpha: 1)
        pageButton.layer.borderColor = (#colorLiteral(red: 0.5803958774, green: 0.2918972373, blue: 1, alpha: 1)).cgColor
        
        switch index {
        case 0:
            pageButton.setTitle("Дальше", for: .normal)
        case 1:
            pageButton.setTitle("Открыть", for: .normal )
        default:
            break
        }
        
        headerLabel.text = header
        subheaderLabel.text = subheader
        imageVIew.image = UIImage(named: imageFile)
        
        pageControll.numberOfPages = 2
        pageControll.currentPage = index
    }
    

   

}
