//
//  SearchBar.swift
//  SwiftSearchGitHubRepositories
//
//  Created by gurasan0110 on 2025/02/03.
//

import SwiftUI

private let returnKeyEnabledPath = "inputDelegate.returnKeyEnabled"

struct SearchBar: UIViewRepresentable {
    let placeholder: String?
    let onSearch: (String) -> Void
    
    init(placeholder: String? = nil, onSearch: @escaping (String) -> Void) {
        self.placeholder = placeholder
        self.onSearch = onSearch
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = placeholder
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onSearch: onSearch)
    }
    
    class Coordinator: NSObject, UISearchBarDelegate {
        let onSearch: (String) -> Void
        
        init(onSearch: @escaping (String) -> Void) {
            self.onSearch = onSearch
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(true, animated: true)
            
            // 初期値はOptional("")
            let searchText = searchBar.text!
            let trimmedSearchText = searchText.trimmingCharacters(in: .whitespaces)
            guard trimmedSearchText.isEmpty else {
                print("trimmedText is not empty")
                return
            }
            
            Task { @MainActor in
                searchBar.searchTextField.setValue(false, forKeyPath: returnKeyEnabledPath)
            }
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            let trimmedSearchText = searchText.trimmingCharacters(in: .whitespaces)
            searchBar.searchTextField.setValue(!trimmedSearchText.isEmpty, forKeyPath: returnKeyEnabledPath)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchBar.setShowsCancelButton(false, animated: true)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            
            // SearchButtonが押せる時点でtextは空ではない
            onSearch(searchBar.text!)
        }
    }
}
