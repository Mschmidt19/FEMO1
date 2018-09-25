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
        

    }
}
