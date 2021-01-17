//
//  ListContactsViewController.swift
//  Contacts
//
//  Created by Kevin Reid on 17/01/2019.
//

import UIKit
import CoreData


class ListContactsViewController: UIViewController {
    var coreDataStack: CoreDataStack!
     var contacts :[Contact] = []
    override func viewDidLoad() {
        super.viewDidLoad()
      setup()
    }
    
    func setup() {
        coreDataStack = CoreDataStack(modelName: "Contact")
       getAllContacts()
    }

    func getAllContacts() {
        let fetchContacts: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        do {
            contacts = try coreDataStack.managedContext.fetch(fetchContacts)
        } catch {
            
        }
    }
    
}
    
    extension ListContactsViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contacts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
            cell.cell(contact: contacts[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150.0
        }
        
    }



