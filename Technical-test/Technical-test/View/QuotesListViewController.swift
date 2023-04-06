//
//  QuotesListViewController.swift
//  Technical-test
//
//  Created by Patrice MIAKASSISSA on 29.04.21.
//

import UIKit

class QuotesListViewController: UIViewController {
    
    private let dataManager:DataManager = DataManager()
    private var market:Market? = nil
    private var quotes: [Quote] = []
    let tableView = UITableView()
    private var selectedIndexPath: IndexPath?
    
    private let reuseId = "quoteTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupAutoLayout()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let selectedIndexPath = self.selectedIndexPath {
            self.tableView.reloadRows(at: [selectedIndexPath], with: .none)
            self.selectedIndexPath = nil
        }
    }
    
    private func fetchData() {
        DataManager().fetchQuotes(completionHandler: handleQuotesResult)
        //In this implementation, for each fetch data the favorites will be reset to false
        //If we want to keep the favorite values they need to be synched from one request to another based on the unique id of a quote,e.g the name of the quote
        //Also favorites should be persisted on a file on appWillTerminate and retrieved on appDidFinishLaunching
    }
    
    private func handleQuotesResult(quotes: [Quote]?, error: Error?) {
        if let quotes = quotes {
            self.quotes = quotes
            tableView.reloadData()
        } else {
            let alert = UIAlertController(title: "Error", message: "An error occurred while fetching quotes.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func addSubviews() {
        tableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
    private func setupAutoLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
}

extension QuotesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        let detailVC = QuoteDetailsViewController(quote: quotes[indexPath.row])
        detailVC.delegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension QuotesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? QuoteTableViewCell {
            
            cell.delegate = self
            let quote = quotes[indexPath.row]
            cell.configure(quote: quote)
            return cell
        }
        return UITableViewCell()
    }
    
}


extension QuotesListViewController: QuoteTableViewCellDelegate {
    
    func didTapFavorite(_ cell: QuoteTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let favorite = quotes[indexPath.item].favorite
            quotes[indexPath.item].favorite = !favorite
        }
    }
}

extension QuotesListViewController: QuoteDetailsViewControllerDelegate {
    
    func didChangeFavorite() {
        if let index = self.selectedIndexPath?.row {
            let favorite = self.quotes[index].favorite
            quotes[index].favorite = !favorite
        }
    }
}
