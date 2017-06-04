//
//  ImageCellTableViewCell.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 6/1/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit

class ImageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.backgroundColor = .red
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(_ person: Person)
    {
        self.selectionStyle = .none
        self.lblTitle.text = person.name
        if let image = person.imgProfile {
            self.img.image = image
        }
        else
        {
            self.img.image = nil
        }
        
    }
}
