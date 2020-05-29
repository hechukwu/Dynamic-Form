import UIKit

class WelcomeCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
