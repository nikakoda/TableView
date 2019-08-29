//
//  IceCreamDetail.swift
//  TableView
//
//  Created by Ника Перепелкина on 21/08/2019.
//  Copyright © 2019 Nika Perepelkina. All rights reserved.
//

import UIKit

class IceCreamDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bigImage: UIImageView!
    var iceCreamStruct : IceCreammm?
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard let svc = segue.source as? RateViewController else {return}
        guard let rating = svc.iceCreamRating else {return}
        rateButton.setImage(UIImage(named: rating), for: .normal) 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // рамка для кнопок оценки и карты
        
        let buttons = [rateButton, mapButton]
        for button in buttons {
            guard button == button else {break}
            button!.layer.cornerRadius = 5
            button!.layer.borderWidth = 1
            button!.layer.borderColor = UIColor.white.cgColor
        }
        
        // ячейка увеличивается
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension 
        
        bigImage.image = UIImage(data: iceCreamStruct!.image! as Data)
        tableView.backgroundColor = #colorLiteral(red: 1, green: 0.867459476, blue: 0.946261704, alpha: 1)
        tableView.separatorColor = #colorLiteral(red: 1, green: 0.5598343611, blue: 0.7528449893, alpha: 1)
        // убираем строки
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        title = iceCreamStruct!.name
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IceCreamDetailCell
        switch indexPath.row {
        case 0:
            cell.keyLabel.text = "Название"
            cell.valueLabel.text = iceCreamStruct!.name
        case 1:
            cell.keyLabel.text = "Ингредиенты"
            cell.valueLabel.text = iceCreamStruct!.ingredient
        case 2:
            cell.keyLabel.text = "Уже пробовал?"
            cell.valueLabel.text = iceCreamStruct!.wasEated ? "Да :)" : "Еще нет"
        default:
            break
        }
        
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    // убрать выделение
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let dvc = segue.destination as! MapViewController
            dvc.iceCreamStruct = self.iceCreamStruct
        }
    }
   
    
   
}
