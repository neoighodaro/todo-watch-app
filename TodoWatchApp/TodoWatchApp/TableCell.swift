
import Foundation
import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var textView: UILabel!
    func setLabel(labelValue:String) {
        textView.text = labelValue
    }
    
}
