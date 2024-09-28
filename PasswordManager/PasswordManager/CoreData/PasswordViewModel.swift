//
//  PasswordViewModel.swift
//  PasswordManager
//
//  Created by Shabnam Siddiqui  on 28/09/24.
//

import CoreData

class PasswordViewModel: ObservableObject {
    @Published var items: [PasswordTable] = []
    private let viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        viewContext = context
        fetchItems()
    }

    func fetchItems() {
        let request: NSFetchRequest<PasswordTable> = PasswordTable.fetchRequest()
        do {
            items = try viewContext.fetch(request)
        } catch {
            print("Error fetching items: \(error)")
        }
    }

    func addItem(accountName: String, email: String , password: String) {
        let newPassword = PasswordTable(context: viewContext)
        newPassword.accountName = accountName
        newPassword.email = email
        newPassword.password = password
        newPassword.createdDate = Date()
        saveContext()
    }

    func updateItem(_ item: PasswordTable,accountName: String, email: String , password: String) {
        item.accountName = accountName
        item.email = email
        item.password = password
        saveContext()
    }

    func deleteItem(_ item: PasswordTable) {
        viewContext.delete(item)
        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
            fetchItems()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
