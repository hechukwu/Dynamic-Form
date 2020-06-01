import UIKit

class AdditionalInfoViewController: UIViewController {

    @IBOutlet weak var veteneryNameLabel: UILabel!
    @IBOutlet weak var veteneryNameTextfield: UITextField!
    @IBOutlet weak var referenceNameLabel: UILabel!
    @IBOutlet weak var referenceNameTextfield: UITextField!
    @IBOutlet weak var SubmitButton: UIButton!

    var viewModel: PetAdoptionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vModel = viewModel else {
            showAlert(title: "Error", message: "There was an error processing your data, please try again.")
            return
        }
        veteneryNameTextfield.delegate = self
        referenceNameTextfield.delegate = self
        veteneryNameLabel.text = vModel.additionalInfoElements?[0].label
        referenceNameLabel.text = vModel.additionalInfoElements?[1].label
        title = vModel.pet?.pages?[2].sections?[0].label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        guard UserDetails.instance.referenceName != ""
                else {
                    showAlert(title: "Error!", message: "Reference name is required.")
                    return
        }
        let vc = SuccessScreenViewController(nibName: "SuccessScreenViewController", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension AdditionalInfoViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == veteneryNameTextfield {
            if let vetName = veteneryNameTextfield.text {
                UserDetails.instance.veteneryName = vetName.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } else if textField == referenceNameTextfield {
            if let refName = referenceNameTextfield.text {
                UserDetails.instance.referenceName = refName.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
}
