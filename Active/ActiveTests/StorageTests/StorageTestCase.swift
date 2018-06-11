//
//  StorageTestCase.swift
//  ActiveTests
//
//  Created by Tiago Maia Lopes on 11/06/18.
//  Copyright © 2018 Tiago Maia Lopes. All rights reserved.
//

import XCTest
import CoreData
@testable import Active

/// The TestCase class used to test the app's storage layer.
/// - Note: TestCase class intended to be subclassed by each file testing the storage classes.
class StorageTestCase: XCTestCase {

    // MARK: - Properties
    
    /// The persistent container used to test the storage classes.
    var memoryPersistentContainer: NSPersistentContainer!
    
    // MARK: setup/tearDown
    
    override func setUp() {
        super.setUp()
        
        /// Create a brand new in-memory persistent container.
        memoryPersistentContainer = makeMemoryPersistentContainer()
    }
    
    override func tearDown() {
        /// Remove the used in-memory persistent container.
        memoryPersistentContainer = nil
        
        super.tearDown()
    }
    
    // MARK: Imperatives
    
    /// Creates an in-memory persistent container to be used by the tests.
    /// - Returns: The in-memory NSPersistentContainer.
    func makeMemoryPersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "Active")
        
        // Declare the in-memory Store description.
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores(completionHandler: { (description, error) in
            // Description's type should always be in-memory when testing.
            precondition(description.type == NSInMemoryStoreType)
            
            if error != nil {
                // If there's an error when loading the store, the storage tests shouldn't proceed.
                fatalError("There's an error when loading the persistent store for test (in-memory configurations).")
            }
        })
        
        return container
    }
    
}
