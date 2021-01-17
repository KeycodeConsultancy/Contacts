//
//  TableViewCell.swift
//  Contacts
//
//  Created by Kevin Reid on 17/01/2019.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var telephoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func cell(contact: Contact) {
        nameLabel.text = contact.name
        emailLabel.text = contact.email
        telephoneNumberLabel.text = contact.telephone
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
