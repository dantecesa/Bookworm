//
//  AddBookView.swift
//  Bookworm
//
//  Created by Dante Cesa on 2/2/22.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var rating: Int = 3
    @State private var genre: String = ""
    @State private var review: String = ""
    @State var reviewPlaceholderString: String = "Enter an optional review here…"
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id:\.self) { genre in
                            Text(genre)
                        }
                    }
                } header: {
                    Text("Tell me about the book")
                }
                
                Section {
                    ZStack {
                        if self.review.isEmpty {
                                TextEditor(text: $reviewPlaceholderString)
                                    .font(.body)
                                    .foregroundColor(.gray)
                                    .disabled(true)
                        }
                        TextEditor(text: $review)
                            .font(.body)
                            .opacity(self.review.isEmpty ? 0.25 : 1)
                    }
                    
                    HStack(alignment: .center) {
                        Spacer()
                        RatingView(rating: $rating)
                        Spacer()
                    }
                } header: {
                    Text("Write a review")
                }
                
                Button("Save") {
                    let newBook = Book(context: moc)
                    
                    newBook.id = UUID()
                    newBook.title = title
                    newBook.author = author
                    newBook.rating = Int16(rating)
                    newBook.genre = genre
                    newBook.review = review
                    
                    try? moc.save()
                    dismiss()
                }
                .disabled(title.isEmpty || author.isEmpty || genre.isEmpty)
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
