import UIKit

class AboutYourHomeViewController: UIViewController {

    @IBOutlet weak var yesnoLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var fencedLabel: UILabel!
    @IBOutlet weak var fencedTextview: UITextView!
    @IBOutlet weak var nextButton: UIButton!

    var viewModel: PetAdoptionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vModel = viewModel else { return }
        yesnoLabel.text = vModel.aboutHomeElements?[0].label
        yesLabel.text = "Yes"
        noLabel.text = "No"
        fencedLabel.text = vModel.aboutHomeElements?[1].label
    }

    @IBAction func yesButtonTapped(_ sender: Any) {
    }

    @IBAction func noButtonTapped(_ sender: Any) {
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
    }
}
