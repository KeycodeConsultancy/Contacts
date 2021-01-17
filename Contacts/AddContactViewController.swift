//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Kevin Reid on 17/01/2019.
//

import UIKit

class AddContactViewController: UIViewController {

    
    var coreDataStack: CoreDataStack!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telephoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    func addContact() {
        coreDataStack = CoreDataStack(modelName: "Contact")
        let contact = Contact(context:self.coreDataStack.managedContext)
        contact.name = nameTextField.text
        contact.email = emailAddressTextField.text
        contact.telephone = telephoneNumberTextField.text
        coreDataStack.saveContext()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(false)
        if  (nameTextField.text?.trimmingCharacters(in: .whitespaces).count)! > 0 && (emailAddressTextField.text?.trimmingCharacters(in: .whitespaces).count)! > 0 && (telephoneNumberTextField.text?.trimmingCharacters(in: .whitespaces).count)! > 0  {
             addContact()
        }
        
    }
    
}
