//
//  NewIceCreamTableViewController.swift
//  TableView
//
//  Created by Ника Перепелкина on 25/08/2019.
//  Copyright © 2019 Nika Perepelkina. All rights reserved.
//

import UIKit

class NewIceCreamTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    var wasEated = false
    
    @IBAction func toggleIsEatedPressed(_ sender: UIButton) {
        if sender == yesButton {
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.617693007, blue: 0.4740757942, alpha: 1)
            noButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            wasEated = true
        } else {
            sender.backgroundColor = #colorLiteral(red: 1, green: 0.617693007, blue: 0.4740757942, alpha: 1)
            yesButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            wasEated = false
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if nameTextField.text == "" || adressTextField.text == "" || ingredientTextField.text == "" {
            let alert = UIAlertController(title: "Упс!", message: "Не все поля заполнены", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Окей", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            
            // получили контекст
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.coreDataStack.persistentContainer.viewContext {
                let iceCream = IceCreammm(context: context)
                iceCream.name = nameTextField.text
                iceCream.ingredient = ingredientTextField.text
                iceCream.adress = adressTextField.text
                iceCream.wasEated = wasEated
                
                if let image = imageView.image {
                    iceCream.image = image.pngData()    // UIImagePNGRepresentation
                }
                
                do {
                    try context.save()
                    print("Сохранение удалось")
                } catch let error as NSError {
                    print("Не удалось сохранить данные \(error), \(error.userInfo)")
                }
            }
            
            performSegue(withIdentifier: "unwindSegueFromNew", sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yesButton.backgroundColor = #colorLiteral(red: 0.9243425727, green: 0.6394632459, blue: 0.909599185, alpha: 1)
        noButton.backgroundColor = #colorLiteral(red: 0.9243425727, green: 0.6394632459, blue: 0.909599185, alpha: 1)
    }

    // MARK: - Table view data source

 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        dismiss(animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let alertController = UIAlertController(title: NSLocalizedString("Источник фотографии", comment: "Источник фотографии"), message: nil, preferredStyle: .actionSheet)
            let cameraAction = UIAlertAction(title: NSLocalizedString("Камера", comment: "Камера"), style: .default) { (action) in
                self.chooceImagePickerAction(source: .camera)
            }
            
            let photoLibAction = UIAlertAction(title: NSLocalizedString("Фото", comment: "Фото"), style: .default) { (action) in
                self.chooceImagePickerAction(source: .photoLibrary)
            }
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("Отмена", comment: "Отмена"), style: .cancel, handler: nil)
            alertController.addAction(cameraAction)
            alertController.addAction(photoLibAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    func chooceImagePickerAction(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            self.present(imagePicker, animated: true, completion: nil)
         }
    }
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
