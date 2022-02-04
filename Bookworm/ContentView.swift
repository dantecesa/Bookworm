//
//  ContentView.swift
//  Bookworm
//
//  Created by Dante Cesa on 2/1/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>
    
    @State var showAddSheet: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Text("Debug: we have \(books.count) books")
                }
                Section {
                    ForEach(books, id:\.self) { book in
                        NavigationLink {
                            Text(book.title ?? "Unknown Title")
                        } label: {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                
                                VStack(alignment: .leading) {
                                    Text(book.title ?? "Unknown Title")
                                        .font(.headline)
                                    Text(book.author ?? "Unknown Author")
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }.onDelete { indexSet in
                        deleteBook(forBooks: Array(books), andIndices: indexSet)
                    }
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAddSheet = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            .sheet(isPresented: $showAddSheet) {
                AddBookView()
            }
        }
    }
    
    private func deleteBook(forBooks books: [Book], andIndices: IndexSet) {
        for index in andIndices {
            let item = books[index]
            moc.delete(item)
        }
        
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
