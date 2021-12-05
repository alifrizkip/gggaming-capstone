//
//  File.swift
//  
//
//  Created by alip on 03/12/21.
//

import CoreData
import Combine

public class CoreDataService {
  public init() {}
  public static let shared = CoreDataService()
  public static let name = "CoreDataModel"

  public let model: NSManagedObjectModel = {
    guard let modelURL = Bundle.module.url(forResource: CoreDataService.name, withExtension: "momd"),
      let model = NSManagedObjectModel(contentsOf: modelURL)
    else { fatalError("Can not find Core Data Model") }
    return model
  }()

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: CoreDataService.name, managedObjectModel: model)
    container.loadPersistentStores { _, error in
      guard let error = error as NSError? else { return }
      fatalError("Unresolved error: \(error), \(error.userInfo)")
    }

    container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    container.viewContext.undoManager = nil
    container.viewContext.shouldDeleteInaccessibleFaults = true
    container.viewContext.automaticallyMergesChangesFromParent = true

    return container
  }()

  public func fetchAll() -> AnyPublisher<[GameLocalEntity], Error> {
    return Future<[GameLocalEntity], Error> { [self] completion in
      let moc = self.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<GameLocalEntity>(entityName: "GameLocalEntity")
      do {
        let results = try moc.fetch(fetchRequest)
        completion(.success(results))
      } catch let err {
        print(err.localizedDescription)
        completion(.failure(DatabaseError.operationFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func isExist(id: Int) -> Bool {
    let moc = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<GameLocalEntity>(entityName: "GameLocalEntity")
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "id == \(id)")

    do {
      let result = try moc.fetch(fetchRequest)
      if Int32(id) == result.first?.id {
        return true
      }
    } catch let err {
      print(err.localizedDescription)
    }

    return false
  }

  public func delete(id: Int) -> Bool {
    let moc = persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<GameLocalEntity>(entityName: "GameLocalEntity")
    fetchRequest.fetchLimit = 1
    fetchRequest.predicate = NSPredicate(format: "id == \(id)")

    do {
      let result = try moc.fetch(fetchRequest)
      if let dataToDelete = result.first {
        moc.delete(dataToDelete)
        try moc.save()
        return true
      }
    } catch let err {
      print(err.localizedDescription)
    }

    return false
  }

  public func add(game: GameUIModel) -> Bool {
    let moc = persistentContainer.viewContext
    let genres: [GenreLocalEntity] = game.genres.map {
      let genre = GenreLocalEntity(context: moc)
      genre.id = Int32($0.id)
      genre.name = $0.name
      genre.slug = $0.slug

      return genre
    }

    let favGame = GameLocalEntity(context: moc)
    favGame.id = Int32(game.id)
    favGame.name = game.name
    favGame.rating = Int32(game.rating)
    favGame.released = game.released
    favGame.backgroundImage = game.backgroundImage
    favGame.descriptionString = game.description
    favGame.descriptionStringRaw = game.descriptionRaw
    favGame.genres = NSSet(array: genres)

    do {
      try moc.save()

      return true
    } catch let err {
      print(err.localizedDescription)
    }

    return false
  }
}
