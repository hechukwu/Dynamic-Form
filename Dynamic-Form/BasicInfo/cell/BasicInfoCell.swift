import UIKit

class BasicInfoCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textfieldType: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configureCell(_ elements: Elements) {
        titleLabel.text = elements.label
        switch elements.label {
        case "Your fullname": textfieldType.keyboardType = .default
        case "Email address": textfieldType.keyboardType = .emailAddress
        case "Phone Number": textfieldType.keyboardType = .numberPad
        case "Date of Birth": textfieldType.keyboardType = .webSearch
        default: return
        }
    }
}
