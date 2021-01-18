//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Kevin Reid on 17/01/2019.
//

import UIKit

class EditContactViewController: UIViewController {

    
    var coreDataStack = CoreDataStack(modelName:"Contact")
   
    var contact: Contact!
    
    var editMode = false
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telephoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
   
    }
    
    func setup() {
        if editMode {
            self.nameTextField.text = contact.name
            self.emailAddressTextField.text = contact.email
            self.telephoneNumberTextField.text = contact.telephone
        }
        showButtons()
    }
    
    
    func showButtons() {
        deleteButton.isHidden = !editMode
        updateButton.isHidden = !editMode
        
    }
    
    @IBAction func deleteContact(_ sender: Any) {
        contact.name = nameTextField.text
        contact.email = emailAddressTextField.text
        contact.telephone = telephoneNumberTextField.text
        coreDataStack.delete(contact: contact)
        showMainMenuViewController()
    }
    
    
    @IBAction func update(_ sender: Any) {
        contact.name = nameTextField.text
        contact.email = emailAddressTextField.text
        contact.telephone = telephoneNumberTextField.text
        coreDataStack.updateContext(contact: contact)
        showMainMenuViewController()
    }
    
    
    func showMainMenuViewController() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ListContactsViewController") as! ListContactsViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func addContact() {
        let contact = Contact(context:self.coreDataStack.managedContext)
        contact.name = nameTextField.text
        contact.email = emailAddressTextField.text
        contact.telephone = telephoneNumberTextField.text
        coreDataStack.saveContext()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        if  (nameTextField.text?.trimmingCharacters(in: .whitespaces).count)! > 0 && (emailAddressTextField.text?.trimmingCharacters(in: .whitespaces).count)! > 0 && (telephoneNumberTextField.text?.trimmingCharacters(in: .whitespaces).count)! > 0 && editMode == false {
             addContact()
        }
    }
    
}
