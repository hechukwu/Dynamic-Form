import UIKit
import Kingfisher

class BasicInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: PetAdoptionViewModel?

    let datePickerView = UIDatePicker()
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel = PetAdoptionViewModel()
        viewModel?.fetchPetModel(delegate: self)
        registerNib()
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        datePickerView.datePickerMode = .date
        datePickerView.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func registerNib() {
        tableView.register(UINib(nibName: WelcomeCell.nibName, bundle: nil), forCellReuseIdentifier: WelcomeCell.reuseIdentifier)
        tableView.register(UINib(nibName: BasicInfoCell.nibName, bundle: nil), forCellReuseIdentifier: BasicInfoCell.reuseIdentifier)
        tableView.register(UINib(nibName: NextButtonCell.nibName, bundle: nil), forCellReuseIdentifier: NextButtonCell.reuseIdentifier)
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isHidden = true
    }

    @objc func handleDatePicker(sender: UIDatePicker) {
        let indexPath = IndexPath(row: 3, section: 1)
        let cell = tableView.cellForRow(at: indexPath) as? BasicInfoCell
        cell?.textfieldType.text = dateFormatter.string(from: sender.date)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension BasicInfoViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vModel = viewModel else { return 0 }
        switch section {
        case 0: return 1
        case 1:
            if let count = vModel.basicInfoElements?.count {
                return count
            }
            return 0
        case 2: return 1
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vModel = viewModel else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeCell.reuseIdentifier) as? WelcomeCell else { return UITableViewCell() }
            cell.welcomeLabel.text = vModel.pet?.pages?[0].sections?[0].label
            if let image = vModel.pet?.pages?[0].sections?[0].elements?[0].file {
                if let url = URL(string: image) {
                    cell.petImageView.kf.setImage(with: url)
                }
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BasicInfoCell.reuseIdentifier) as? BasicInfoCell else { return UITableViewCell() }
            cell.textfieldType.delegate = self
            if let elements = vModel.basicInfoElements {
                let element = elements[indexPath.row]
                cell.configureCell(element)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NextButtonCell.reuseIdentifier) as? NextButtonCell else { return UITableViewCell() }
            cell.delegate = self
            return cell
        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        default:
            return 100
        }
    }
}

extension BasicInfoViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.keyboardType == .webSearch {
            textField.inputView = datePickerView
            dateFormatter.dateFormat = "MMM dd, yyyy"
            textField.text = dateFormatter.string(from: datePickerView.date)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.keyboardType == .default {
            if let fullname = textField.text {
                UserDetails.instance.fullname = fullname.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } else if textField.keyboardType == .emailAddress {
            if let email = textField.text {
                UserDetails.instance.email = email.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } else if textField.keyboardType == .numberPad {
            if let number = textField.text {
                UserDetails.instance.phoneNumber = number.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } else if textField.keyboardType == .webSearch {
            if let dob = textField.text {
                UserDetails.instance.dob = dob.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
}

extension BasicInfoViewController: PetAdoptionDelegate, NextButtonDelegate {

    func onGetPetModel(response: PetAdoptionModel) {
        guard let vModel = viewModel else { return }
        if let formName = response.name {
            title = formName
        } else {
            title = "Unable to fetch pet details"
        }
        vModel.pet = response
        vModel.updateBasicInfoElements(response: response)
        tableView.reloadData()
        tableView.isHidden = false
    }

    func onFailure(_ error: String) {
        title = "Unable to fetch pet details"
        tableView.isHidden = true
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func showNextVC() {
    }
}
