//
//  NoteDataManager.swift
//  HW3
//
//  Created by Danylo Sluzhynskyi on 06.12.2020.
//

import Foundation
import CoreData
class NoteDataManager {
    var noteId = 0
    var dataSource: [Note] = []
    var removedSource: [Note] = []
    var filteredNotes: [Note] = []
    var context: NSManagedObjectContext!
    /**
     Fetch all notes from CoreData
     */
    func fetchNotes() {
        var notes: [Note] = []

        do {
            notes = try context.fetch(Note.fetchRequest())
        } catch { print("Failed: \(error)") }

        self.dataSource = notes.filter { $0.deletionDate == nil }
        self.removedSource = notes.filter { $0.deletionDate != nil }
    }
    func refresh() {
        do {
            try context.save()
        } catch { print("Failed: \(error)") }
    }
    // MARK: - CRUD functions

    /**
        Creates a Note and saves  it  to dataSource with passed parameters.

        - Parameter name:   The name of Note.
        - Parameter text:   The text of Note.
        - Parameter tags:   The tags of Note.
        - Returns: Void
    */

    func createNote(name: String, text: String, tags: Set <String> = []) -> Note {
        let newNote = Note(context: self.context)
        newNote.noteId = Int64(self.noteId)
        newNote.name = name
        newNote.text = text
        newNote.tags = tags
        newNote.creationDate = Date()
        self.noteId += 1
        self.refresh()
        self.fetchNotes()
        print(dataSource)
        return newNote
    }

    /**
        Returns a Note by `id` provided.

        - Parameter id:   The id of Note.
        - Returns Note
    */

    func getNote(id: Int) -> Note? {
        dataSource.first(where: { $0.noteId == id })
    }
    /**
        Updates database by `id` to  another Note.

        - Parameter id:   The id of Note.
        - Parameter note:   Custom Note that you provide.
        - Returns Void
    */
    func setNote(id noteId: Int, note: Note) {
        for (index, element) in self.dataSource.enumerated() {
            if element.noteId == noteId {
                self.dataSource[index] = note
                self.refresh()
            }
        }
    }
    /**
        Delete from database by `id`.

        - Parameter id:   The id of Note.
        - Returns Void
    */
    func removeNote(id: Int) {
        let note = dataSource.first { $0.noteId == id }!
        context.delete(note)
        self.refresh()
    }


    // MARK: - Additional functions

    func toggleFavorite(id noteId: Int) -> Bool {
        // makes note favorite propery inverse to previous
        for (index, element) in self.dataSource.enumerated() {
            if element.noteId == noteId {
                let note = self.dataSource[index]
                self.dataSource[index].isFavorite = !note.isFavorite
                self.refresh()
                return true
            }
        }
        return false
    }

    func popNote(id noteId: Int) {
        for (index, note) in self.dataSource.enumerated() {
            if note.noteId == noteId {
                note.deletionDate = Date()
                self.removedSource.append(note)
                self.dataSource.remove(at: index)
                self.refresh()
            }
        }
    }


    func restoreNote(id: Int) {
        for (index, note) in self.removedSource.enumerated() {
            if note.noteId == id {
                note.deletionDate = nil
                self.dataSource.append(note)
                self.removedSource.remove(at: index)
                self.refresh()
            }
        }
    }



    func searchBy(name noteName: String) {
        let filtered = self.dataSource.filter {
            $0.name!.lowercased().contains(noteName.lowercased())
        }
        self.filteredNotes = filtered
    }

    func alreadyPresented(note: Note) -> Bool {
        dataSource.contains(note)
    }

    func filterBy(tags: Set <String>) {
        let filtered = dataSource.filter {
            ($0.tags!).intersection(tags).count == tags.count
        }
        self.filteredNotes = filtered

    }
    func sortingNotes() {
        self.dataSource.sort { $0.name! < $1.name! }
    }

}
