//
//  ToiletViewModel.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 02/07/2022.
//

import Foundation
import CoreLocation

class ToiletViewModel {
    
    // MARK: State
    
    enum ToiletState {
        case loading
        case loaded(toilets: [Toilet])
        case error
    }
    
    // MARK: Completions
    
    var toiletsStateCompletion: ((ToiletState) -> Void)?
    var userLocationCompletion: ((CLLocation) -> Void)?
    
    // MARK: Properties
    
    private let navigator: Navigator
    private let toiletService = ToiletService()
    private var toilets: [Toilet] = []
    
    // MARK: Init
    
    init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    // MARK: Events
    
    func viewDidLoad() {
        fetchLocation()
        Task {
            await fetchToilets()
        }
    }
    
    func filterPmrToilets(_ shouldFilter: Bool) {
        if shouldFilter {
            let filteredToilets = toilets.filter { $0.hasPmrAccess }
            toiletsStateCompletion?(.loaded(toilets: filteredToilets))
        } else {
            toiletsStateCompletion?(.loaded(toilets: toilets))
        }
    }
    
    func toiletTapped(at index: Int) {
        let toilet = toilets[index]
        navigator.toToiletDetails(toilet)
    }
    
    // MARK: Privates
    
    private func fetchLocation() {
        if let location = GeolocationManager.shared.lastLocation {
            userLocationCompletion?(location)
        } else {
            GeolocationManager.shared.updateLocation { [weak self] newLocation in
                if let newLocation = newLocation {
                    self?.userLocationCompletion?(newLocation)
                }
            }
        }
    }
    
    private func fetchToilets() async {
        toiletsStateCompletion?(.loading)
        do {
            toilets = try await toiletService.getToiletList()
            toiletsStateCompletion?(.loaded(toilets: toilets))
        } catch {
            toiletsStateCompletion?(.error)
        }
    }
}
