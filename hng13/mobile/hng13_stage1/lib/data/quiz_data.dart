import '../models/quiz_models.dart';

final questions = [
  Question(
    category: "Programming",
    question: "Which programming language was created by Guido van Rossum?",
    options: ["Java", "Python", "C++", "JavaScript"],
    correctAnswerIndex: 1,
  ),
  Question(
    category: "Frameworks",
    question:
        "Which framework is developed by Google for building mobile applications?",
    options: ["React Native", "Flutter", "Xamarin", "Ionic"],
    correctAnswerIndex: 1,
  ),
  Question(
    category: "Tools",
    question: "What does 'Git' stand for in version control?",
    options: [
      "Global Information Tracker",
      "General Interface Tool",
      "Git Isn't Terminal",
      "It doesn't stand for anything",
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    category: "Tech History",
    question: "In what year was the first iPhone released?",
    options: ["2005", "2007", "2009", "2010"],
    correctAnswerIndex: 1,
  ),
  Question(
    category: "Programming",
    question: "Which of these is NOT a JavaScript framework?",
    options: ["React", "Vue", "Angular", "Flask"],
    correctAnswerIndex: 3,
  ),
  Question(
    category: "Tools",
    question: "Which company developed the VS Code editor?",
    options: ["Google", "Microsoft", "Apple", "JetBrains"],
    correctAnswerIndex: 1,
  ),
  Question(
    category: "Tech History",
    question: "What was the first object-oriented programming language?",
    options: ["C++", "Java", "Simula", "Smalltalk"],
    correctAnswerIndex: 2,
  ),
  Question(
    category: "Frameworks",
    question:
        "Which framework uses the concept of 'Components' and 'Services'?",
    options: ["Flutter", "React", "Angular", "Vue"],
    correctAnswerIndex: 2,
  ),
  Question(
    category: "Programming",
    question: "What does 'API' stand for?",
    options: [
      "Application Programming Interface",
      "Advanced Programming Instruction",
      "Automated Program Interface",
      "Application Process Integration",
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    category: "Tools",
    question: "Which database is known as a NoSQL document database?",
    options: ["MySQL", "PostgreSQL", "MongoDB", "SQLite"],
    correctAnswerIndex: 2,
  ),
];
