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
        
        list.append(Question(questionText: "Which language does Angular JS use? ", choiceA: "Java", choiceB: "Javascript", choiceC: "Ruby", choiceD: "Scala", answer: 2))
        
        list.append(Question(questionText: "Which language was created by Apple in 2014?", choiceA: "Ring", choiceB: "Swift", choiceC: "Dart", choiceD: "Groovy", answer: 2))
        
        list.append(Question(questionText: "How old is Python?", choiceA: "10 years old", choiceB: "2 years old", choiceC: "27 years old", choiceD: "18 years old", answer: 3))
        
        list.append(Question(questionText: "Which language was founded by Guido van Rossum?", choiceA: "Ruby", choiceB: "Python", choiceC: "Java", choiceD: "C++", answer: 2))
        
        list.append(Question(questionText: "In SQL, what would the 'FOREIGN KEY' command do?", choiceA: "Link two tables together", choiceB: "Delete a table", choiceC: "Create a new key", choiceD: "Link two keys together", answer: 1))
        
        list.append(Question(questionText: "Which of the following is NOT a backend language?", choiceA: "CSS", choiceB: "Java", choiceC: "Ruby", choiceD: "Perl", answer: 1))
        
//        list.append(Question(questionText: "In the command line, what does 'cat' do?", choiceA: "String1", choiceB: "String2", choiceC: "String3", choiceD: "String4", answer: 1))
        
        list.append(Question(questionText: "In the command line, what does 'cd..' do?", choiceA: "List directories", choiceB: "Make a new directory", choiceC: "Move up one directory", choiceD: "List the contents of a file", answer: 3))
        
        list.append(Question(questionText: "In the command line, which command makes a new directory?", choiceA: "echo", choiceB: "mkdir", choiceC: "tail", choiceD: "curl", answer: 2))
        
        list.append(Question(questionText: "Which command on a mac keyboard will open the console?", choiceA: "Shift + cmd + H", choiceB: "Shift + cmd + A", choiceC: "cmd + J", choiceD: "alt + cmd + J", answer: 4))
        
        list.append(Question(questionText: "What percentage of tech startups fail within their first year?", choiceA: "29%", choiceB: "76%", choiceC: "90%", choiceD: "50%", answer: 3))
        
        list.append(Question(questionText: "In 2017, which of the following frameworks was the most commonly used?", choiceA: "React", choiceB: "Angular JS", choiceC: ".Net Core", choiceD: "Node.js", answer: 1))
        
        list.append(Question(questionText: "In 2017, which of the following languages was the least commonly used?", choiceA: "Coffeescript", choiceB: "Perl", choiceC: "Haskell", choiceD: "Groovy", answer: 4))
        
        list.append(Question(questionText: "What is PHP short for?", choiceA: "Personal Hypertext Page", choiceB: "Personal Home Page", choiceC: "Programming Hypertext Page", choiceD: "Programme Home Page", answer: 2))
        
        list.append(Question(questionText: "IP Address. What does IP stand for?", choiceA: "Internet Protocol", choiceB: "Information Packet", choiceC: "Internet Page", choiceD: "Incoming Page", answer: 2))
        
        list.append(Question(questionText: "In all programming languages, what does 'int' stand for?", choiceA: "Internet", choiceB: "Integer", choiceC: "Initialize", choiceD: "Internal", answer: 2))
        
//        list.append(Question(questionText: "What symbol in Javascript seperates statements?", choiceA: "String1", choiceB: "String2", choiceC: "String3", choiceD: "String4", answer: 1))
        
        list.append(Question(questionText: "What does the symbol modulo do?", choiceA: "Adds two integers together", choiceB: "Multiplies an array", choiceC: "Gives you the total", choiceD: "Finds the remainder", answer: 4))
        
        list.append(Question(questionText: "What of the below is NOT a database?", choiceA: "SQL", choiceB: "Firebase", choiceC: "RSpec", choiceD: "PSQL", answer: 3))
        
        list.append(Question(questionText: "Which method would correct this array alphabetically? [F, E, J, O, A, Q]", choiceA: ".length", choiceB: ".trim", choiceC: ".toLowerCase", choiceD: ".sort", answer: 4))
        
        

    }
}
