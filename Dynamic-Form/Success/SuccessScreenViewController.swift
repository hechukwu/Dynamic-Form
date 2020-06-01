import UIKit

class SuccessScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let answers = [
        FormAnswers(titleText: "Fullname:", userDetailText: UserDetails.instance.fullname),
        FormAnswers(titleText: "Email:", userDetailText: UserDetails.instance.email),
        FormAnswers(titleText: "Phone number:", userDetailText: UserDetails.instance.phoneNumber),
        FormAnswers(titleText: "Date of birth:", userDetailText: UserDetails.instance.dob),
        FormAnswers(titleText: "Do you have a yard:", userDetailText: "\(UserDetails.instance.userHasYard ?? false)"),
        FormAnswers(titleText: "Is your yard fenced:", userDetailText: UserDetails.instance.yardIsFenced),
        FormAnswers(titleText: "Reference name:", userDetailText: UserDetails.instance.referenceName),
        FormAnswers(titleText: "Vetenery name:", userDetailText: UserDetails.instance.veteneryName)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        registerNib()
    }

    func registerNib() {
        tableView.register(UINib(nibName: SuccessCell.nibName, bundle: nil), forCellReuseIdentifier: SuccessCell.reuseIdentifier)
    }
}

extension SuccessScreenViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SuccessCell.reuseIdentifier) as? SuccessCell else { return UITableViewCell() }
        let answer = answers[indexPath.row]
        cell.titleLabel.text = answer.titleText
        cell.userDetailLabel.text = answer.userDetailText
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
