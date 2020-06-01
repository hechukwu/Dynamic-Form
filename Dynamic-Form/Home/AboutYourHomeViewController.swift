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
    @IBOutlet weak var fencedBgView: UIView!

    var viewModel: PetAdoptionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vModel = viewModel else {
            showAlert(title: "Error", message: "There was an error processing your data, please try again.")
            return
        }
        fencedBgView.isHidden = true
        yesnoLabel.text = vModel.aboutHomeElements?[0].label
        yesLabel.text = "Yes"
        noLabel.text = "No"
        fencedTextview.layer.borderWidth = 0.4
        fencedTextview.layer.borderColor = UIColor.black.cgColor
        fencedLabel.text = vModel.aboutHomeElements?[1].label
        title = vModel.pet?.pages?[1].sections?[0].label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

    @IBAction func yesButtonTapped(_ sender: UIButton) {
        UserDetails.instance.userHasYard = true
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { success in
            self.noButton.isSelected = false
            self.yesButton.isSelected = true
            self.fencedBgView.isHidden = false
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
    }

    @IBAction func noButtonTapped(_ sender: UIButton) {
        UserDetails.instance.userHasYard = false
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { success in
            self.yesButton.isSelected = false
            self.noButton.isSelected = true
            self.fencedBgView.isHidden = true
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
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
