import Foundation


struct Note:Hashable {
    var noteId: Int
    var name, text: String
    var tags:Set <String> = Set<String>()
    var isFavorite: Bool = false
    var creationDate = Date()
    var deletionDate: Date?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(noteId)
    }
}

var n1 = Note(noteId:0, name:"Hello", text:"world", tags:["start", "init", "first"])
class NoteDataManager{
    var noteId = 0
    var dataSource:[Int: Note] = [:]
    var removedSource:[Int: Note] = [:]
    
    // CRUD functions
    func createNote(noteName:String,noteText:String,noteTags:Set <String> = []) -> Note {
        var n = Note(noteId:self.noteId, name:noteName, text:noteText, tags:noteTags)
        self.dataSource[self.noteId] = n
        self.noteId += 1
        return n 
    }

    func getNote(noteId id:Int) -> Note?{
        return self.dataSource[id]
    }

    func popNote(noteId id:Int) -> Note?{
        var rn = self.dataSource.removeValue(forKey:id)
        rn.deletionDate = Date()
        self.removedSource[id] = rn
        return rn
    }
    // Additional functions
    func setFavorite(noteId id:Int) -> Bool {
        if (self.dataSource[id] != nil) {
            self.dataSource[id]!.isFavorite = true
            return true
        }
        return false
    }

    func restoreNote(noteId id:Int) -> Bool {
        var rn = self.removedSource.removeValue(forKey:id)
        if (rn != nil){
            self.dataSource[id] = rn
            return true
        }
        return false
    }
    
    func searchByName(noteName name:String) -> Note? {
        let notes = Array(self.dataSource.values)
        for n in notes{
            if (n.name == name){
                return n
            }
        }
        return nil
    }
    
}

var ndm1 = NoteDataManager()
ndm1.createNote(noteName:"Hello", noteText:"world")

// print(ndm1.dataSource)