import UIKit

protocol GenericTableViewDelegate: AnyObject {
    associatedtype Item
    func didSelect(item: Item)
}

class GenericTableView<Cell: BaseCell<Item>, Item>: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private var items: [Item] = []
    
    weak var delegate: AnyObject?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableView()
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.description())
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
    
    func setItems(_ items: [Item]) {
        self.items = items
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.description(), for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        cell.config(item: items[indexPath.row])
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < items.count else { return }
        if let delegate = delegate as? any GenericTableViewDelegate {
            delegate.didSelect(item: items[indexPath.row])
        }
    }
}
