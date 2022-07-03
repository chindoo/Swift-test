//
//  ToiletListViewController.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 02/07/2022.
//

import UIKit
import CoreLocation

class ToiletListViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    private var toilets: [Toilet] = []
    private var currentLocation: CLLocation?
    private lazy var viewModel = ToiletViewModel(navigator: Navigator(self))
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        observeViewData()
        viewModel.viewDidLoad()
    }
    
    // MARK: IBActions
    
    @IBAction private func pmrFilterTapped(_ sender: UISwitch) {
        viewModel.filterPmrToilets(sender.isOn)
    }
    
    // MARK: Privates
    
    private func setupViews() {
        self.title = "Toilets"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func observeViewData() {
        viewModel.toiletsStateCompletion = { [weak self] state in
            switch state {
            case .loading:
                DispatchQueue.main.async {
                    self?.activityIndicator.isHidden = false
                    self?.activityIndicator.startAnimating()
                }
                
            case let .loaded(toilets: toilets):
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    self?.toilets = toilets
                    self?.tableView.reloadData()
                }
                
            case .error:
                #warning("TO DO: handle error")
            }
        }
        
        viewModel.userLocationCompletion = { [weak self] location in
            self?.currentLocation = location
            if self?.toilets.isEmpty == false {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: TableViewDataSource

extension ToiletListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toilets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let toilet = toilets[indexPath.row]
        var distanceString: String?
        if let location = currentLocation {
            let distance: Double = location.distance(from: toilet.location)
            distanceString = distance.standardFormatDistance()
        }
        
        let cell = tableView.dequeue(with: ToiletListTableViewCell.self, for: indexPath)
        cell.setup(with: toilet, distance: distanceString)
        return cell
    }
}

// MARK: TableViewDelegate

extension ToiletListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toiletTapped(at: indexPath.row)
    }
}
