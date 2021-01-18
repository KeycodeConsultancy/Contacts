//
//  CoreDataStack.swift
//  Contacts
//
//  Created by Kevin Reid on Created by Kevin Reid on 17/01/2019.
//

import Foundation
import CoreData

public class CoreDataStack {
    
    private let modelName: String
    private let usesFatalError: Bool
    var people : [Contact] = []
    
    public init(modelName: String, usesFatalError: Bool = false) {
        self.modelName = modelName
        self.usesFatalError = usesFatalError
    }
    
    public lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
            container.loadPersistentStores { (storeDescription, error) in
                self.handle(error)
            }
            return container
    }()
    
    public func saveContext(completion: @escaping (Result<Bool, Error>) -> () = {_ in}) {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
            completion(.success(true))
        } catch {
            handle(error) {
                completion(.failure(error))
            }
        }
    }
    
    
    func updateContext(contact: Contact) {

        let entity =  NSEntityDescription.entity(forEntityName: "Contact", in: managedContext)!
        let updateRequest = NSBatchUpdateRequest(entity: entity)
        
        updateRequest.predicate = NSPredicate(format: "id == %@", contact.id!)
        
        updateRequest.propertiesToUpdate = ["name" : contact.name!, "telephone" : contact.telephone!]
        updateRequest.resultType = .updatedObjectsCountResultType

        do {
          let result = try managedContext.execute(updateRequest) as! NSBatchUpdateResult
          print("\(result.result ?? 0) objects updated")
          
        } catch let error as NSError {
          print("Could not batch update. \(error), \(error.userInfo)")
        }
    }
    
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try managedContext.fetch(fetchRequest) as? [T]
            
            return fetchedObjects ?? [T]()
            
        } catch {
            print(error)
            return [T]()
        }
        
    }
    
    func delete(contact: Contact) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        fetchRequest.predicate = NSPredicate(format: "id == %@", contact.id!)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
          try managedContext.execute(deleteRequest)
        } catch let error as NSError {
          print("Could not delete all data. \(error), \(error.userInfo)")
        }
        saveContext()
    }
       
        
        
    private func handle(_ error: Error?, completion: @escaping () -> () = {}) {
        if let error = error as NSError? {
            let message = "CoreDataStack -> \(#function): Unresolved error: \(error), \(error.userInfo)"
            if usesFatalError {
                fatalError(message)
            } else {
                print(message)
            }
            completion()
        }
    }
    }

