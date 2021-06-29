//
//  CommentCell.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 21.04.2021.
//

import UIKit

class CommentCell: UITableViewCell {

    static let identifier = String(describing: CommentCell.self)
    static let nib = UINib(nibName: identifier, bundle: nil)
    
    @IBOutlet weak var commentatorLabel: UILabel!
    @IBOutlet weak var commentaryLabel: UILabel!
    
    public var commentator : Commentator?{
        didSet{
            if let commentator = commentator?.email {
                commentatorLabel.text = commentator
            }
            if let commentary = commentator?.comment {
                commentaryLabel.text = ": \(commentary)"
            }
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
