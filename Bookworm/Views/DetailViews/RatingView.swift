//
//  RatingView.swift
//  Bookworm
//
//  Created by Dante Cesa on 2/3/22.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var maxRating: Int = 5
    
    var label: String = ""
    
    var offImage: Image?
    var onImage: Image = Image(systemName: "star.fill")
    
    var offColor: Color = Color.gray
    var onColor: Color = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maxRating + 1, id:\.self) { number in
                renderImage(forIndex: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        withAnimation {
                            rating = number
                        }
                    }
                    .accessibilityElement()
                    .accessibilityLabel(label)
                    .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment:
                            if rating < maxRating {
                                rating += 1
                            }
                        case .decrement:
                            if rating > 1 {
                                rating -= 1
                            }
                        default:
                            break
                        }
                    }
            }
        }
    }
    
    func renderImage(forIndex index: Int) -> Image {
        if index > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
