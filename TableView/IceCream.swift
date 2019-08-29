//
//  IceCream.swift
//  TableView
//
//  Created by Ника Перепелкина on 20/08/2019.
//  Copyright © 2019 Nika Perepelkina. All rights reserved.
//

import UIKit
import CoreData

class IceCream: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var fetchResultsController: NSFetchedResultsController<IceCreammm>!
    var searchController: UISearchController!
    var filteredResultArray: [IceCreammm] = []
    
    
    
    var iceCreams: [IceCreammm] = []
    //      IceCreamStruct(name: "Клубника", ingredient: "Клубника, молоко, вафельный рожок", image: "1", wasEated: false, adress: "Красноярск, //пр. Мира, 86"),
    //      IceCreamStruct(name: "Пломбир", ingredient: "Сливки, молоко, вафельный рожок", image: "2", wasEated: false, adress: "Красноярск, пр. //Мира, 86"),
    //      IceCreamStruct(name: "Шоколад", ingredient: "Шоколад, молоко, вафельный рожок", image: "3", wasEated: false, adress: "Красноярск, пр. //Мира, 86"),
    //      IceCreamStruct(name: "Черника", ingredient: "Черника, молоко, вафельный рожок", image: "4", wasEated: false, adress: "Красноярск, пр. //Мира, 86"),
    //      IceCreamStruct(name: "Ассорти", ingredient: "Клубника/шоколад/черника, молоко, вафельный рожок", image: "5", wasEated: false, adress: //"Красноярск, пр. Мира, 86"),
    //  ]
    
    
    @IBAction func cancel(segue: UIStoryboardSegue) {}
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func filterContentFor(searchText text: String) {
        filteredResultArray = iceCreams.filter{ (iceCreams) -> Bool in
            return(iceCreams.name?.lowercased().contains(text.lowercased()))!
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate = self
        
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        searchController.searchBar.tintColor = .white
        
        // чтобы строка поиска не переходила на след. страницу
        definesPresentationContext = true
        
        // ячейка увеличивается
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        
        
        
        // создаем запрос
        let fetchRequest: NSFetchRequest<IceCreammm> = IceCreammm.fetchRequest()
        // создаем дескриптор (фильтр)
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultsController.delegate = self
            do {
                try fetchResultsController.performFetch()
                iceCreams = fetchResultsController.fetchedObjects!
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "pageViewController") as? PageViewController {
            present(pageViewController, animated: true, completion: nil)
        }
    }
    
    
    
    
    // MARK: - fetch result controller delegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert: guard let indexPath = newIndexPath else { break }
        tableView.insertRows(at: [indexPath], with: .fade)
        case .delete: guard let indexPath = indexPath else { break }
        tableView.deleteRows(at: [indexPath], with: .fade)
        case .update: guard let indexPath = indexPath else { break }
        tableView.reloadRows(at: [indexPath], with: .fade)
        default:
            tableView.reloadData()
        }
        iceCreams = controller.fetchedObjects as! [IceCreammm]
    }
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredResultArray.count
        }
            return iceCreams.count
    }
    
    
    
    func iceCreamToDismplayAt(indexPath: IndexPath) -> IceCreammm {
        let iceCream: IceCreammm
        if searchController.isActive && searchController.searchBar.text != "" {
            iceCream = filteredResultArray[indexPath.row]
        } else {
            iceCream = iceCreams[indexPath.row]
        }
        return iceCream
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! IceCreamCell
        let iceCream = iceCreamToDismplayAt(indexPath: indexPath)
        
        cell.iceCreamImage.image = UIImage(data: iceCream.image! as Data)
        cell.iceCreamImage.layer.cornerRadius = 32.5
        cell.iceCreamImage.clipsToBounds = true
        cell.nameLabel.text = iceCream.name
        //  cell.locationLabel.text = restaurants[indexPath.row].location
        cell.ingredienceLabel.text = iceCream.ingredient
        
        // в виде тернарного оператора
        cell.accessoryType = iceCream.wasEated ? .checkmark : .none
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    /*
     // AlertController
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let alert = UIAlertController(title: nil, message: "Желаете заказать?", preferredStyle: .actionSheet)
     let yesAnswer = UIAlertAction(title: "Да! Номер заказа: \(indexPath.row  )", style: .default) {
     (action: UIAlertAction) -> Void in
     
     let yesAlert = UIAlertController(title: nil, message: "Мороженое закончилось:(", preferredStyle: .alert)
     let yesAction = UIAlertAction(title: "Ок, закажу другое", style: .default, handler: nil)
     yesAlert.addAction(yesAction)
     self.present(yesAlert, animated: true, completion: nil)
     }
     
     let alreadyEatTitle = self.iceCreamWasEated[indexPath.row] ? "Я не пробовал" : "Уже пробовал"
     let alreadyEat = UIAlertAction(title: alreadyEatTitle, style: .default) {
     (action) in
     let cell = tableView.cellForRow(at: indexPath)
     
     self.iceCreamWasEated[indexPath.row] = !self.iceCreamWasEated[indexPath.row]
     cell?.accessoryType = self.iceCreamWasEated[indexPath.row] ? .checkmark : .none
     
     // // чтобы checkmark не переиспользовалось
     // self.iceCreamWasEated[indexPath.row] = true
     // cell?.accessoryType = .checkmark
     }
     let cancel = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
     
     alert.addAction(cancel)
     alert.addAction(yesAnswer)
     alert.addAction(alreadyEat)
     present(alert, animated: true, completion: nil)
     
     
     // чтобы не выделялась ячейка
     tableView.deselectRow(at: indexPath, animated: true)
     }
     
     */
    
    
    //   // удаление свайпом влево
    //   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    //       if editingStyle == .delete {
    //           self.iceCreamNames.remove(at: indexPath.row)
    //           self.iceCreamImages.remove(at: indexPath.row)
    //           self.iceCreamWasEated.remove(at: indexPath.row)
    //       }
    //      // tableView.reloadData()
    //       tableView.deleteRows(at: [indexPath], with: .fade)
    //   }
    
    // поделиться или удалить
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let share = UITableViewRowAction(style: .default, title: "Поделиться") {
            (action, indexPath) in
            let defaultText = "Попробуй это мороженое: " + self.iceCreams[indexPath.row].name!
            
            if let image = UIImage(data: self.iceCreams[indexPath.row].image! as Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        
        
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            self.iceCreams.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                let objectToDelete = self.fetchResultsController.object(at: indexPath)
                context.delete(objectToDelete)
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        share.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        return [delete, share]
    }
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! IceCreamDetail
                dvc.iceCreamStruct = iceCreamToDismplayAt(indexPath: indexPath)
            }
        }
    }
}


extension IceCream: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(searchText: searchController.searchBar.text!)
        tableView.reloadData()
    }
}

// не закрывать searchBar NavigationController-ом
extension IceCream: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text == "" {
            navigationController?.hidesBarsOnSwipe = false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        navigationController?.hidesBarsOnSwipe = true
    }
}
