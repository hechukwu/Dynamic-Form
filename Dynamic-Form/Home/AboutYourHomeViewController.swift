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
        guard let vModel = viewModel else {
            showAlert(title: "Error", message: "There was an error processing your data, please try again.")
            return
        }
        yesnoLabel.text = vModel.aboutHomeElements?[0].label
        yesLabel.text = "Yes"
        noLabel.text = "No"
        fencedTextview.layer.borderWidth = 0.4
        fencedTextview.layer.borderColor = UIColor.black.cgColor
        fencedLabel.text = vModel.aboutHomeElements?[1].label
        title = vModel.pet?.pages?[1].sections?[0].label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

    @IBAction func yesButtonTapped(_ sender: Any) {
        noButton.isSelected = false
        yesButton.isSelected = true
        UserDetails.instance.userHasYard = true
    }

    @IBAction func noButtonTapped(_ sender: Any) {
        yesButton.isSelected = false
        noButton.isSelected = true
        UserDetails.instance.userHasYard = false
    }

    @IBAction func nextButtonTapped(_ sender: Any) {
        guard UserDetails.instance.userHasYard != nil, let vModel = viewModel else {
            showAlert(title: "Error!", message: "Please indicate if you have a fence.")
            return
        }
        UserDetails.instance.yardIsFenced = fencedTextview.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let vc = AdditionalInfoViewController(nibName: "AdditionalInfoViewController", bundle: nil)
        vc.viewModel = vModel
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
