//
//  PhoneContent2.swift
//  Native3
//
//  Created by William Berggren on 2023-04-27.
//

import SwiftUI
import Contacts

struct Contact: Identifiable {
    let id = UUID()
    let name: String
}

struct PhoneContacts: View {
    @State private var contacts: [Contact] = []
    @State private var newContactName: String = ""

    var body: some View {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Enter contact name", text: $newContactName) 
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: addContact) {
                            Text("Add Contact")
                        }
                    }
                    .padding()
                    
                    HStack {
                            Button("Sort Contacts") {
                                sortContacts()
                            }
                            .padding(.trailing, 10)
                            
                            Button("Duplicate Contacts") {
                                duplicateContacts()
                            }
                        }
                        .padding()
                    
                    List {
                        ForEach(0..<contacts.count, id: \.self) { index in
                            HStack {
                                Text(contacts[index].name)
                                Spacer()
                                Button(action: {
                                    deleteContact(at: index)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
                        }
                    }
                }
                .navigationBarTitle("Contacts")
            }
            .onAppear {
                requestAccess()
            }
        }


    private func addContact() {
            let trimmedName = newContactName.trimmingCharacters(in: .whitespaces)
            if trimmedName.isEmpty {
                
                return
            }
            let newContact = Contact(name: trimmedName)
            contacts.insert(newContact, at: 0)
            newContactName = ""
        }

    
    private func deleteContact(at index: Int) {
            contacts.remove(at: index)
        }
    
    private func sortContacts() {
            contacts.sort { $0.name < $1.name }
        }
    
    private func duplicateContacts() {
        
        while contacts.count < 10 {
                contacts += contacts
            }
        
        if contacts.count >= 10 {
            let firstTenContacts = Array(contacts.prefix(10))
            for _ in 0..<1000 {
                contacts += firstTenContacts
            }
        }
    }

    
    private func requestAccess() {
        let store = CNContactStore()
    
        store.requestAccess(for: .contacts) { granted, error in
            if let error = error {
                print("Error requesting access to contacts:", error)
                return
            }
        
            if granted {
                print("Access to contacts granted")
                self.contacts = self.fetchContacts()
            } else {
                print("Access to contacts denied")
            }
        }
    }
    
    private func fetchContacts() -> [Contact] {
        let contactStore = CNContactStore()
        var contacts = [Contact]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        
        let predicate = CNContact.predicateForContacts(matchingName: "Test contact")
            let request = CNContactFetchRequest(keysToFetch: keys)
            request.predicate = predicate
        
        do {
            try contactStore.enumerateContacts(with: request) { (contact, stop) in
                let fullName = "\(contact.givenName) \(contact.familyName)"
                contacts.append(Contact(name: fullName))
            }
        } catch {
            print("Failed to fetch contacts:", error)
        }
        
        return contacts
    }


}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneContacts()
    }
}
