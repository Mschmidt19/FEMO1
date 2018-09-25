//
//  QuestionList.swift
//  FEMO
//
//  Created by Marek Schmidt on 9/21/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import Foundation

class QuestionList {
    var list = [Question]()
    
    init() {
        list.append(Question(questionText: "What is TDD short for?", choiceA: "Test Development Driven", choiceB: "Testing Drive Develop", choiceC: "Test Driven Development", choiceD: "Testing Drunk Drivers", answer: 3))
        
        list.append(Question(questionText: "What is TDD short for?", choiceA: "Don't Repeat Yourself", choiceB: "Do Repeat Yourself", choiceC: "Do Really Yell", choiceD: "Don't React Yodelling", answer: 1))
        
        list.append(Question(questionText: "Which of the following is an example of an instance variable in Ruby?", choiceA: "<drink>", choiceB: "Class drink", choiceC: "@@drink", choiceD: "@drink ", answer: 4))
        
        list.append(Question(questionText: "Which is the oldest coding language?", choiceA: "Java", choiceB: "Perl", choiceC: "Erlang", choiceD: "C++", answer: 4))
        
        list.append(Question(questionText: "Which statement is typically the first program newbies write?", choiceA: "Goodbye, Planet!", choiceB: "Hello, Galaxy", choiceC: "Hello, World!", choiceD: "Goodbye, Universe!", answer: 3))
        
        list.append(Question(questionText: "Which language was founded by Yukihiro Matsumoto?", choiceA: "Haskell", choiceB: "PHP", choiceC: "Perl", choiceD: "Ruby", answer: 4))
        
        list.append(Question(questionText: "Which of the following is a library within Python?", choiceA: "Stunning Sandwich", choiceB: "Beautiful Soup", choiceC: "Pretty Panini", choiceD: "Fabulous Frittata", answer: 2))
        
        list.append(Question(questionText: "Which command would embolden text in HTML?", choiceA: "<b>", choiceB: "<samp>", choiceC: "<>blink", choiceD: "<img>", answer: 1))
        
        list.append(Question(questionText: "What is API short for?", choiceA: "Application Programming Interface", choiceB: "Application Programming Information", choiceC: "Apply Programming Interface", choiceD: "Applying Programme Interface", answer: 1))
        
        list.append(Question(questionText: "Which command in HTML is used for largest heading?", choiceA: "<h6>", choiceB: "<a>", choiceC: "<h1.", choiceD: "<body>", answer: 3))
        

    }
}
