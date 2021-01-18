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
    @IBOutlet weak var tableview: UITableView!
    var contacts :[Contact] = []
    var contact: Contact!
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.getAllContacts()
        self.tableview.reloadData()
    }
}
    
    extension ListContactsViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return contacts.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
            cell.cell(contact: contacts[indexPath.row])
       
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150.0
        }
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            contact = contacts[indexPath.row]
            performSegue(withIdentifier: "EditViewController", sender: self)
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if let editView = segue.destination as? EditContactViewController {
                editView.contact = contact
                editView.editMode = true
                editView.title = "Edit Contact"
               }
           }
    
    }



