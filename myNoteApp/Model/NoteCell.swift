//
//  NoteCellTableViewCell.swift
//  myNoteApp
//
//  Created by ДаблЧери on 5/23/19.
//  Copyright © 2019 CAT&GIRL. All rights reserved.
//

import UIKit
import CoreData

class NoteCell: UITableViewCell {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
  
    func configureCell(note: Note){
        self.descriptionLabel?.text = note.value(forKey: "details") as? String
    
        
    }
    
}

