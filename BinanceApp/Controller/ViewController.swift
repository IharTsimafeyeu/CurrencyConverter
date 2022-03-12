import UIKit

final class ViewController: UIViewController {
    
    // MARK: Private
    // MARK: - Outlets
    private var activityIndicator = UIActivityIndicatorView (style: .large)
    private let tableView = UITableView()
    private var searchController = UISearchController()
    
    //MARK: Private
    //MARK: Properties
    private var dataSource: [CurrencyClientModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    private var desiredArray: [CurrencyClientModel] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraintsForTableView()
        setupUIView()
        setupTableView()
        setupSearchController()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showActivityIndicator()
        APIManager.instance.getAssets() { data in
            self.dataSource = data
            self.hideActivityIndicator()
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
    private func setupUIView() {
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
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchBar.searchTextField.layer.masksToBounds = true
        searchController.searchBar.searchTextField.layer.cornerRadius = 5
        searchController.searchBar.barTintColor = .systemIndigo
    }
    
    //MARK: Private
    //MARK: - Helpers
    private func showActivityIndicator() {
        view.isUserInteractionEnabled = false
        let viewController = tabBarController ?? navigationController ?? self
        activityIndicator.frame = CGRect(
            x: 0,
            y: 0,
            width: viewController.view.frame.width,
            height: viewController.view.frame.width
        )
        viewController.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    private func hideActivityIndicator() {
        view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}

//MARK: TableViewDelegate, TableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return desiredArray.count
        } else {
            return dataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier,
                                                    for: indexPath) as? TableViewCell {
            let coin = (searchController.isActive) ? desiredArray[indexPath.row] : dataSource[indexPath.row]
            cell.setInfo(data: coin)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: SearchResultUpdating, SearchBarDelegate
extension ViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func filterContent(for SearchText: String) {
        desiredArray = dataSource.filter { array -> Bool in
            let nameOfCurrency = array.name.lowercased()
                return nameOfCurrency.hasPrefix(SearchText.lowercased())
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchedText = searchController.searchBar.text {
            filterContent(for: searchedText)
            tableView.reloadData()
        }
    }
}
