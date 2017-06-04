//
//  CustomCell01.swift
//  RxSwift_01
//
//  Created by Nestor Javier Hernandez Bautista on 6/3/17.
//  Copyright © 2017 Definity First. All rights reserved.
//

import UIKit

class CustomCell01: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.backgroundColor = .blue
        
    }

    func loadCell(_ buddy: Buddy)
    {
        self.selectionStyle = .none
        self.lbl.text = buddy.name
        
        if let image = buddy.image {
         
            self.img.image = image
            self.lbl.text = "Done"
            self.activityIndicator.stopAnimating()            
        }
        else
        {
            self.img.image = UIImage(named: "ColorSquares")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
