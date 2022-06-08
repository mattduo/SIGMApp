//
//  SearchBarView.swift
//  SIGMA
//
//  Created by Matt on 7/6/2022.
//

import UIKit

class SearchBarView: UICollectionReusableView {
    
    @IBOutlet weak var searchBar: UISearchBar!
            
    
    
    func setUpSearchBar() {
        self.searchBar?.showsScopeBar = true
        self.searchBar?.placeholder = "hibby"
        self.searchBar?.scopeButtonTitles = ["Hi", "Bye", "Hi"]

//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.showsCancelButton = false
//        searchController.searchBar.returnKeyType = UIReturnKeyType.done
    }
    
}

//extension SearchBarView: UISearchBarDelegate {
////    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
////        webService.newExercises.removeAll()
////        ExerciseDictionaryViewController().exerciseCollectionView.reloadData()
////
////        guard let searchText = searchBar.text, searchText.isEmpty == false else {
////            return
////        }
//////        self.searchBar.inputAccessoryViewController?.dismiss(animated: <#T##Bool#>)
////        Task {
////            URLSession.shared.invalidateAndCancel()
////            webService.currentRequestIndex = 0
////            await ExerciseDictionaryViewController().requestExercisesNamed(searchText)
////        }
////    }
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//
//    }
//
//}
//
////extension SearchBarView: UISearchResultsUpdating {
////    func updateSearchResults(for searchController: UISearchController) {
////        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
////        let searchText = searchBar.text!
////
////        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
////    }
////
////    func filterForSearchTextAndScopeButton(searchText: String, scopeButton: String) {
////
////    }
////}
