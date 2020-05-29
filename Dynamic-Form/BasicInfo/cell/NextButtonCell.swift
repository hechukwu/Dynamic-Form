import UIKit

protocol NextButtonDelegate {
    func showNextVC()
}

class NextButtonCell: UITableViewCell, NibLoadable {

    @IBOutlet weak var nextButton: UIButton!

    var delegate: NextButtonDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        delegate?.showNextVC()
    }
}
