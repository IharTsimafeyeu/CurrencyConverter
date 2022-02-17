import UIKit

final class ViewController: UIViewController {
    
    // MARK: Private
    // MARK: - Outlets
    private let tableView = UITableView()
    private var dataSource: [CurrencyClientModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraintsForTableView()
        setupUI()
        setupTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        APIManager.instance.getAssets() { data in
            self.dataSource = data
        }
    }
    // MARK: Private
    // MARK: - Setups
    private func addSubviews() {
        view.addSubview(tableView)
    }
    private func addConstraintsForTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    private func setupUI() {
        view.backgroundColor = AppColor.viewBackgroundColor
        title = "Exchange Rates"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func setupTableView() {
        tableView.rowHeight = 75
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.backgroundColor = AppColor.viewBackgroundColor
        tableView.separatorStyle = .none
    }
}
//MARK: TableViewDelegate, TableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell {
            cell.updateInfo(data: dataSource[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

