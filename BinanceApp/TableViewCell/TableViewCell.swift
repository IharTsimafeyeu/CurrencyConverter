import UIKit

final class TableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "TableViewCell"
    
    // MARK: Private
    // MARK: - Outlets
    private let mainView = UIView()
    private let currencyNameLabel = UILabel()
    private let currencyValueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public
    // MARK: - Setups
    func updateInfo(data: CurrencyClientModel) {
        currencyNameLabel.text = data.name
        var roundedValue = String(format: "%.1f", data.priceUsd)
        if "\(data.priceUsd)".count > 4 {
            roundedValue = String(format: "%.4f", data.priceUsd)
        }
        currencyValueLabel.text = "\(roundedValue)"
    }
    
    // MARK: Private
    private func addSubviews() {
        contentView.addSubview(mainView)
        mainView.addSubview(currencyNameLabel)
        mainView.addSubview(currencyValueLabel)
    }
    
    private func addConstraints() {
        addConstraintsForMainView()
        addConstraintsForName()
        addConstraintsForValue()
    }
    
    private func addConstraintsForMainView() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    private func addConstraintsForName() {
        currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyNameLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        currencyNameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5).isActive = true
        currencyNameLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5).isActive = true
        currencyNameLabel.trailingAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
    }
    
    private func addConstraintsForValue() {
        currencyValueLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyValueLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        currencyValueLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5).isActive = true
        currencyValueLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5).isActive = true
        currencyValueLabel.leadingAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
    }
    
    private func setupUI() {
        setupUIForMainView()
        setupUIForLabels()
    }
    
    private func setupUIForMainView() {
        mainView.backgroundColor = AppColor.cellBackgroundColor
        contentView.backgroundColor = AppColor.viewBackgroundColor
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
    }
    
    private func setupUIForLabels() {
        currencyNameLabel.font = .systemFont(ofSize: 25, weight: .medium)
        currencyValueLabel.font = .systemFont(ofSize: 25, weight: .light)
        
        currencyNameLabel.textAlignment = .left
        currencyValueLabel.textAlignment = .right
    }
}
