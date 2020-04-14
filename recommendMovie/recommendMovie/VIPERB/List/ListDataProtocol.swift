//
//  ListDataProtocol.swift
//  sohuhy
//
//  Created by mojue on 2019/8/15.
//  Copyright © 2019 sohu. All rights reserved.
//

import Foundation

protocol ListDataProtocol: class {
    // MARK: -
    // MARK: - Data information
    var viewModels: [Section] { get set }
    
    func numberOfSections() -> Int
    func numberOfItemsInSection(at index: Int) -> Int
    
    func item(at indexPath: IndexPath) -> ViewModelType?
    func section(in index: Int) -> Section?
    
    // MARK: -
    // MARK: - Data manipulation
    /// Get data from the network
    //    func loadList(_ loadType: LoadType, localCompletion: LoadCompletion?, completion : LoadCompletion?)
    //    func loadSection(at index: Int, completion : LoadCompletion?)
    //    func loadItem(at indexPath: IndexPath, completion : LoadCompletion?)
    
    /// Retrieve data from memory or disk
    func updateSection(section: Section, at index: Int)
    func updateItem(item: ViewModelType, at indexPath: IndexPath)
    
    /// Insert data
    func insertSection(section: Section, at index: Int)
    func insertItem(item: ViewModelType, at indexPath: IndexPath)
     
    /// Delete data
    func deleteSection(at index: Int)
    func deleteItem(at indexPath: IndexPath)
    
    /// Clear all data
    func clearList()
    
    // MARK: -
    // MARK: - Database operation
    /// Data storage
    func saveListInDB(completion : Completion?)
    func saveSectionInDB(section: Section, completion : Completion?)
    func saveItemInDB(item: ViewModelType, completion : Completion?)
    
    /// delete data
    func deleteItemInDB(item: ViewModelType, completion : Completion?)
    
    // MARK: -
    // MARK: - action
    func didTapItem(at indexPath: IndexPath)
    
    // MARK: -
    // MARK: - legitimacy
    func indexPathAccessibleInViewModels(_ indexPath: IndexPath) -> Bool
}

/// Optional methods related to view state.
extension ListDataProtocol {
    
    // MARK: -
    // MARK: - Data information
    func numberOfSections() -> Int {
        return self.viewModels.count
    }
    
    func numberOfItemsInSection(at index: Int) -> Int {
        #if DEBUG
        assert(index < self.viewModels.count, "Index out of bounds exception")
        #else
        #endif
        return section(in: index)?.items.count ?? 0
    }
    
    func item(at indexPath: IndexPath) -> ViewModelType? {
        if indexPathAccessibleInViewModels(indexPath) == false {
            return nil
        }
        
        return self.viewModels[indexPath.section].items[indexPath.row]
    }
    
    func section(in index: Int) -> Section? {
        #if DEBUG
        assert(index < self.viewModels.count, "Index out of bounds exception")
        #else
        #endif
        if index >= self.viewModels.count {
            return nil
        }
        
        return self.viewModels[index]
    }
    
    // MARK: -
    // MARK: - Data manipulation
    /// Get data from the network
    //    func loadList(_ loadType: LoadType, loadLocal: LoadCompletion?, completion : LoadCompletion?) {}
    //    func loadSection(at index: Int, completion : LoadCompletion?) {}
    //    func loadItem(at indexPath: IndexPath, completion : LoadCompletion?) {}
    
    /// Retrieve data from memory
    func updateSection(section: Section, at index: Int) {
        #if DEBUG
        assert(index < self.viewModels.count, "Index out of bounds exception")
        #else
        #endif
        
        if index >= self.viewModels.count {
            return
        }
        
        self.viewModels[index] = section
    }
    func updateItem(item: ViewModelType, at indexPath: IndexPath) {
        guard indexPathAccessibleInViewModels(indexPath) else {
            return
        }
        
        self.viewModels[indexPath.section].items[indexPath.row] = item
    }
    
    /// Insert data
    func insertSection(section: Section, at index: Int) {
        #if DEBUG
        assert(index <= self.viewModels.count, "Index out of bounds exception")
        #else
        #endif
        
        if index > self.viewModels.count {
            return
        }
        
        self.viewModels.insert(section, at: index)
    }
    func insertItem(item: ViewModelType, at indexPath: IndexPath) {
        #if DEBUG
        assert(indexPath.section <= self.viewModels.count, "Index out of bounds exception (indexPath.section)")
        assert(indexPath.row <= self.viewModels[indexPath.section].items.count, "Index out of bounds exception (indexPath.row)")
        #else
        #endif
        
        if indexPath.section > self.viewModels.count ||
            indexPath.row > self.viewModels[indexPath.section].items.count {
            return
        }
        self.viewModels[indexPath.section].items.insert(item, at: indexPath.row)
    }
    
    /// Delete data
    func deleteSection(at index: Int) {
        #if DEBUG
        assert(index < self.viewModels.count, "Index out of bounds exception")
        #else
        #endif
        
        if index >= self.viewModels.count {
            return
        }
        
        self.viewModels.remove(at: index)
    }
    func deleteItem(at indexPath: IndexPath) {
        guard indexPathAccessibleInViewModels(indexPath) else {
            return
        }
        
        self.viewModels[indexPath.section].items.remove(at: indexPath.row)
    }
    
    /// Clear all data
    func clearList() {
        self.viewModels = []
    }
    
    // MARK: -
    // MARK: - Database operation
    /// Data storage
    func saveListInDB(completion : Completion?) {}
    func saveSectionInDB(section: Section, completion : Completion?) {}
    func saveItemInDB(item: ViewModelType, completion : Completion?) {}
    
    /// delete data
    func deleteItemInDB(item: ViewModelType, completion : Completion?) {}
    
    // MARK: -
    // MARK: - action
    func didTapItem(at indexPath: IndexPath) {}
    
    // MARK: -
    // MARK: - legitimacy
    func indexPathAccessibleInViewModels(_ indexPath: IndexPath) -> Bool {
        
        #if DEBUG
        assert(indexPath.section < self.viewModels.count, "Index out of bounds exception ( please check indexPath.section)")
        assert(indexPath.row < self.viewModels[indexPath.section].items.count, "Index out of bounds exception (please check indexPath.row)")
        #else
        #endif
        
        if indexPath.section >= self.viewModels.count ||
            indexPath.row >= self.viewModels[indexPath.section].items.count {
            return false
        }
        
        return true
    }
    
}



