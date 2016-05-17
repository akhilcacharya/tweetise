//
//  ChirpCellTableViewCell.swift
//  BirdStorm
//
//  Created by Akhil Acharya  on 5/13/16.
//  Copyright © 2016 akhilcacharya.me. All rights reserved.
//

import UIKit

class ChirpCell: UITableViewCell {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String!){
        super.init(style: UITableViewCellStyle.Value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setViews(currentModel: ChirpEntry){
        self.titleView.text = currentModel.title
        self.dateView.text = currentModel.getFormattedDate()
    }

}
