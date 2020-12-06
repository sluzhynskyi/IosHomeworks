//
//  NoteDataManager.swift
//  HW3
//
//  Created by Danylo Sluzhynskyi on 06.12.2020.
//

import Foundation
class NoteDataManager {
    var noteId = 0
    var dataSource: [Note] = []
    var removedSource: [Note] = []
    var filteredNotes: [Note] = []

    // CRUD functions

    func createNote(name noteName: String, text noteText: String, tags noteTags: Set <String> = []) -> Note {
        let note = Note(noteId: self.noteId, name: noteName, text: noteText, tags: noteTags)
        self.dataSource.append(note)
        self.noteId += 1
        return note
    }
    func getNote(id noteId: Int) -> Note? {
        dataSource.first(where: { $0.noteId == noteId })
    }

    func setNote(id noteId: Int, note: Note) -> Bool {
        for (index, element) in self.dataSource.enumerated() {
            if element.noteId == noteId {
                self.dataSource[index] = note
                return true
            }
        }
        return false
    }

    func popNote(id noteId: Int) -> Note? {
        for (index, element) in self.dataSource.enumerated() {
            if element.noteId == noteId {
                self.dataSource[index].deletionDate = Date()
                self.removedSource.append(self.dataSource[index])
                self.dataSource.remove(at: index)
                return element
            }
        }
        return nil
    }
    // Additional functions
    func toggleFavorite(id noteId: Int) -> Bool {
        // makes note favorite propery inverse to previous
        for (index, element) in self.dataSource.enumerated() {
            if element.noteId == noteId {
                let note = self.dataSource[index]
                self.dataSource[index].isFavorite = !note.isFavorite
                return true
            }
        }
        return false
    }

    func restoreNote(id noteId: Int) -> Note? {
        for (index, element) in self.removedSource.enumerated() {
            if element.noteId == noteId {
                self.dataSource.append(element)
                self.removedSource.remove(at: index)
                return element
            }
        }
        return nil
    }

    func searchBy(name noteName: String) {
        let filtered = self.dataSource.filter {
            $0.name.lowercased().contains(noteName.lowercased())
        }
        self.filteredNotes = filtered
    }

    func alreadyPresented(note: Note) -> Bool {
        dataSource.contains(note)
    }

    func filterBy(tags: Set <String>) {
        let filtered = dataSource.filter {
            $0.tags.intersection(tags).count == tags.count
        }
        self.filteredNotes = filtered

    }
    func sortingNotes() {
        self.dataSource.sort { $0.name < $1.name }
    }

}
