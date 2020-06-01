import UIKit

class SuccessCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userDetailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
