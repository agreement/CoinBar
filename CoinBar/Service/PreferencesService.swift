//
//  PreferencesService.swift
//  CoinBar
//
//  Created by Adam Waite on 18/09/2017.
//  Copyright © 2017 adamjwaite.co.uk. All rights reserved.
//

import Foundation

protocol PreferencesServiceProtocol {
    
    func getPreferences() -> Preferences
    
    func setFavouriteCoins(_ coins: [Coin])
    func addFavouriteCoin(_ coin: Coin)
    func removeFavouriteCoin(_ coin: Coin)
    
    func setCurrency(currency: Preferences.Currency)

}

final class PreferencesService: PreferencesServiceProtocol {
    
    private let persistence: PersistenceProtocol
    
    init(persistence: PersistenceProtocol) {
        self.persistence = persistence
    }
    
    // MARK: - Get Preferences
    
    func getPreferences() -> Preferences {
        return persistence.readPreferences()
    }
    
    // MARK: - Coins
    
    func setFavouriteCoins(_ coins: [Coin]) {
        persistence.writePreferences {
            var preferences: Preferences = $0
            preferences.favouriteCoins = coins.map { $0.id }
            return preferences
        }
    }
    
    func addFavouriteCoin(_ coin: Coin) {
        persistence.writePreferences {
            var preferences: Preferences = $0
            preferences.favouriteCoins.append(coin.id)
            return preferences
        }
    }
    
    func removeFavouriteCoin(_ coin: Coin) {
        persistence.writePreferences {
            var preferences: Preferences = $0
            if let index = preferences.favouriteCoins.index(of: coin.id) {
                preferences.favouriteCoins.remove(at: index)
            }
            return preferences
        }
    }
    
    // MARK: - Currency
    
    func setCurrency(currency: Preferences.Currency) {
        persistence.writePreferences {
            var preferences: Preferences = $0
            preferences.currency = currency.rawValue
            return preferences
        }
    }
    
}
