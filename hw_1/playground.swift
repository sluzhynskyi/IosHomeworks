import Foundation

struct Note{
    var noteId: Int
    var name, text: String
    var tags:Set <String> = Set<String>()
    var isFavorite: Bool = false
    var creationDate = Date()
    var deletionDate: Date?
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.name == rhs.name && lhs.text == lhs.text
    }
}

class NoteDataManager{
    var noteId = 0
    var dataSource:[Note] = []
    var removedSource: [Note] = []
    
    // CRUD functions
    func createNote(noteName:String,noteText:String,noteTags:Set <String> = []) -> Note {
        var n = Note(noteId:self.noteId, name:noteName, text:noteText, tags:noteTags)
        self.dataSource.append(n)
        self.noteId += 1
        return n 
    }

    func getNote(noteId id:Int) -> Note?{
        for n in self.dataSource{
            if n.noteId == id{
                return n
            }
        }
        return nil
    }

    func popNote(noteId id:Int) -> Note?{
        for (index, element) in self.dataSource.enumerated() {
           if element.noteId == id {
               self.removedSource.append(element)
               self.dataSource.remove(at:index)
               return element
           }
        }
        return nil
    }
    // Additional functions
    func setFavorite(noteId id:Int) -> Bool {
        for (index, element) in self.dataSource.enumerated() {
            if element.noteId == id {
                self.dataSource[index].isFavorite = true
                return true
            }
        }
        return false
    }

    func restoreNote(noteId id:Int) -> Note? {
        for (index, element) in self.dataSource.enumerated() {
           if element.noteId == id {
               self.removedSource.remove(at:index)
               self.dataSource.append(element)
               return element
           }
        }
        return nil
    }
    
    func searchByName(noteName name:String) -> Note? {
        for n in self.dataSource{
            if (n.name == name){
                return n
            }
        }
        return nil
    }

    func alreadyPresented(note n:Note) -> Bool{
        if self.dataSource.contains(n){
            return true
        }
        return false
    }
    
    func filterByTags(tags t:Set<String>)->[Note] {
        var filtered = [Note]()
        for n in self.dataSource{
            if (n.tags.intersection(t).count == t.count){
                filtered.append(n)
            } 
        }
        return filtered
    }
    func sortingNotes(){
        self.dataSource.sorted { $0.name > $1.name }
    }

}

var ndm1 = NoteDataManager()
ndm1.createNote(noteName:"Hello", noteText:"world")

// print(ndm1.dataSource)
