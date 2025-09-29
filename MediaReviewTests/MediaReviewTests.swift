//
//  MediaReviewTests.swift
//  MediaReviewTests
//
//  Created by Alexa Nohemi Lara Carvajal on 28/09/25.
//

import Testing
@testable import MediaReview
struct MediaReviewTests {

    @Test ("name must not be empty or whitespace")
    func testNameValidation(){
        #expect(Song.isValidName("This is a name"))
        #expect(!Song.isValidName(""))
        #expect(!Song.isValidName("     "))
        #expect(Song.isValidgenre("This is a name"))
        #expect(!Song.isValidgenre(""))
        #expect(!Song.isValidgenre("     "))
    }
    
    @Test ("Length boundaries still valid")
    func testNameBoundary(){
        #expect(Song.isValidName("A"))
        #expect(Song.isValidName(String(repeating: "X", count: 255)))
        #expect(Song.isValidgenre("A"))
        #expect(Song.isValidgenre(String(repeating: "X", count: 255)))
    }
    
    @Test ("Number")
    func testrating(){
        #expect(Song.notEmptyRating(2))
        #expect(!Song.notEmptyRating(0))
    }

}
