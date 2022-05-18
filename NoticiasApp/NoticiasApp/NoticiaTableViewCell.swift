//
//  NoticiaTableViewCell.swift
//  NoticiasApp
//
//  Created by Mac13 on 06/04/22.
//

import UIKit

class NoticiaTableViewCell: UITableViewCell {

    @IBOutlet weak var tituloNoticiaLbl: UILabel!
    
    @IBOutlet weak var descripcionNoticiaLbl: UILabel!
    
    @IBOutlet weak var fuenteNoticiaView: UILabel!
    
    @IBOutlet weak var imagenNoticiaIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
