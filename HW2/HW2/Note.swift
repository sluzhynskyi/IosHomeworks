import Foundation

struct Note {
    let noteId: Int
    var name, text: String
    var tags: Set <String> = Set<String>()
    var isFavorite: Bool = false
    var creationDate = Date()
    var deletionDate: Date?

}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.name == rhs.name && lhs.text == lhs.text // Comment: id?
    }
}

class NoteDataManager {
    var noteId = 0
    var dataSource: [Note] = []
    var removedSource: [Note] = []

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
    func setFavorite(id noteId: Int) -> Bool {
        for (index, element) in self.dataSource.enumerated() {
            if element.noteId == noteId {
                self.dataSource[index].isFavorite = true
                return true
            }
        }
        return false
    }

    func restoreNote(id noteId: Int) -> Note? {
        for (index, element) in self.removedSource.enumerated() {
            if element.noteId == noteId {
                self.removedSource.remove(at: index)
                self.dataSource.append(element)
                return element
            }
        }
        return nil
    }

    func searchBy(name noteName: String) -> [Note] {
        let filtered = self.dataSource.filter {
            $0.name.lowercased().contains(noteName.lowercased())
        }
        return filtered
    }



    func alreadyPresented(note: Note) -> Bool {
        dataSource.contains(note)
    }

    func filterBy(tags: Set <String>) -> [Note] {
        let filtered = dataSource.filter {
            $0.tags.intersection(tags).count == tags.count
        }
        return filtered

    }
    func sortingNotes() {
        self.dataSource.sort { $0.name < $1.name }
    }

}
