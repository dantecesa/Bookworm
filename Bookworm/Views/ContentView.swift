//
//  ContentView.swift
//  Bookworm
//
//  Created by Dante Cesa on 2/1/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State var showAddSheet: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(books, id:\.self) { book in
                        NavigationLink {
                            DetailView(book: book)
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
                        deleteBook(at: indexSet)
                    }
                }
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
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
    
    private func deleteBook(at offsets: IndexSet) {
        for offset in offsets {
            let item = books[offset]
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
