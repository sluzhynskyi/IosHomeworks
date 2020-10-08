import Foundation

struct Note{
    var noteId: Int
    var name, text: String
    var tags: Set <String> = Set<String>()
    var isFavorite: Bool = false
    var creationDate = Date()
    var deletionDate: Date?
    init(noteId: Int, name:String, text:String, tags:Set <String>) {
        self.noteId = noteId
        self.name = name
        self.text = text
        self.tags = tags
    }
    
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
        for (index, element) in self.dataSource.enumerated() {
            if self.dataSource[index].noteId == id{
                return self.dataSource[index]
            }
        }
        return nil
    }
    func setNote(noteId id:Int, newNote n: Note) -> Bool{
        for (index, element) in self.dataSource.enumerated() {
            if element.noteId == id {
                self.dataSource[index] = n
                return true
            }
        }
        return false
    }
    
    func popNote(noteId id:Int) -> Note?{
        for (index, element) in self.dataSource.enumerated() {
            if element.noteId == id {
                self.dataSource[index].deletionDate = Date()
                self.removedSource.append(self.dataSource[index])
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
        for (index, element) in self.removedSource.enumerated() {
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
        self.dataSource.sort { $0.name < $1.name }
    }
    
}
// TEST
var ndm1 = NoteDataManager()
ndm1.createNote(noteName:"Fav Books",
                noteText:"Lord of the Rings, Harry Potter and the Goblet of Fire",
                noteTags:["books", "fantasy", "popular",])
ndm1.createNote(noteName:"Mafia strategy",
                noteText:"Not nervous, play with outher players, find mafia, ...",
                noteTags:["remember", "popular", "game"])
ndm1.createNote(noteName:"Dogs breeds",
                noteText:"Labrador Retrievers, German Shepherds, Golden Retrievers, Beagles, German Shorthaired Pointers",
                noteTags:["remember", "popular", "dogs"]) 
ndm1.createNote(noteName:"Stocks portfolio",
                noteText:"S&P 500, AAPL, AMZN, MSFT, GOOG",
                noteTags:["money", "stocks",])
ndm1.createNote(noteName:"Plan for a day",
                noteText:"do hw, to  meet with girl, to kiss with girl, ... ",
                noteTags:["plans", "remember", "personal"])
ndm1.createNote(noteName:"Fav boardgame",
                noteText:"secret hitler, classic mafia, DND, Spy ",
                noteTags:["popular", "game"])

// Test CRUD operations for Note

print(ndm1.dataSource.count) // Test Create method

print(ndm1.getNote(noteId:1)) // Test Read method

var n1 = ndm1.getNote(noteId:1)! // Test update note
n1.name += "!!!!"
ndm1.setNote(noteId: n1.noteId, newNote:n1)

print(ndm1.popNote(noteId:4)) // Test Delete method


ndm1.setFavorite(noteId:1) // Test set favorite note
print(ndm1.getNote(noteId:1)) 

print(ndm1.restoreNote(noteId:4)) // Test Restore
print(ndm1.getNote(noteId:4))

print(ndm1.alreadyPresented(note:n1)) // True

var n2 = n1
n2.name = "New mafia strategy"


print(ndm1.alreadyPresented(note:n2)) // False

print(ndm1.filterByTags(tags:["popular", "remember"])) // Test filtering

print(ndm1.searchByName(noteName:"Dogs breeds")) // Test searchByName

// Test sortingNotes
print(ndm1.dataSource) // Before sorting
ndm1.sortingNotes()
print(ndm1.dataSource) // After sorting
