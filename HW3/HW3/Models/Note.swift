import Foundation

class Note {
    let noteId: Int
    var name = "", text: String = ""
    var tags: Set <String> = Set<String>()
    var isFavorite: Bool = false
    var creationDate = Date()
    var deletionDate: Date?
    init(noteId: Int, name: String, text: String, tags: Set<String>) {
        self.noteId = noteId
        self.name = name
        self.text = text
        self.tags = tags
    }
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.noteId == rhs.noteId
    }
}
