//
//  ItemCell.swift
//  DreamLister
//
//  Created by Younoussa Ousmane Abdou on 11/29/16.
//  Copyright © 2016 Younoussa Ousmane Abdou. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbIMG: UIImageView!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var detailLBL: UILabel!

    func configCell(item: Item) {
        
        titleLBL.text = item.title
        priceLBL.text = "$\(item.price)"
        detailLBL.text = item.details
        thumbIMG.image = item.toImage?.image as? UIImage
    }
}
