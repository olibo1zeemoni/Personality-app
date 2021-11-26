//
//  QuestionVC.swift
//  Personality-quiz
//
//  Created by Olibo moni on 25/11/2021.
//

import UIKit

class QuestionVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var multiStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    
    
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangeLabel1: UILabel!
    @IBOutlet weak var rangeLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    
    var questionIndex = 0
    var chosenAnswer: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        
    }
    func updateUI(){
        singleStackView.isHidden = true
        multiStackView.isHidden = true
        rangedStackView.isHidden = true
        
        
        let currentQuestion = questions[questionIndex]
        let currentAnswer = currentQuestion.answers
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        
        navigationItem.title = "Question #\(questionIndex + 1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        
        switch currentQuestion.type {
        case .single:
            updateSingleStack(using: currentAnswer)
        case .multiple:
            updateMultiple(using: currentAnswer)
        case .ranged:
            updateRangeStack(using: currentAnswer)
        }
        
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
        
    }
    
    func updateMultiple(using answer: [Answer]) {
        multiStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        
        multiLabel1.text = answer[0].text
        multiLabel2.text = answer[1].text
        multiLabel3.text = answer[2].text
        multiLabel4.text = answer[3].text
        
    }
    
    func updateRangeStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: true)
        rangeLabel1.text = answers.first?.text
        rangeLabel2.text = answers.last?.text
    }
    
    
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            chosenAnswer.append(currentAnswers[0])
        case singleButton2:
            chosenAnswer.append(currentAnswers[1])
        case singleButton3:
            chosenAnswer.append(currentAnswers[2])
        case singleButton4:
                chosenAnswer.append(currentAnswers[4])
        default:
            break
        }
        
        nextQuestion()
        
    }
   
    
    func nextQuestion(){
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "Results", sender: nil)
        }
        
    }
    
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswer = questions[questionIndex].answers
        if multiSwitch1.isOn{
            chosenAnswer.append(currentAnswer[0])
        }
        if multiSwitch2.isOn{
            chosenAnswer.append(currentAnswer[1])
        }
        if multiSwitch3.isOn{
            chosenAnswer.append(currentAnswer[2])
        }
        if multiSwitch4.isOn{
            chosenAnswer.append(currentAnswer[3])
        }
        
        
        nextQuestion()
    }
    

    
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value *              Float(currentAnswers.count - 1)))
            chosenAnswer.append(currentAnswers[index])
        nextQuestion()

    }
    
    
    @IBSegueAction func showResults(_ coder: NSCoder) -> ResultsVC? {
        return ResultsVC(coder: coder, responses: chosenAnswer)
    }
    
    

}

var questions: [Question] = [
    
    Question(
      text: "Which activities do you enjoy?",
      type: .multiple,
      answers: [
        Answer(text: "Swimming", type: .turtle),
        Answer(text: "Sleeping", type: .cat),
        Answer(text: "Cuddling", type: .rabbit),
        Answer(text: "Eating", type: .dog)
      ]
    ),
    
  Question(
    text: "Which food do you like the most?",
    type: .single,
    answers: [
      Answer(text: "Steak", type: .dog),
      Answer(text: "Fish", type: .cat),
      Answer(text: "Carrots", type: .rabbit),
      Answer(text: "Corn", type: .turtle)
    ]
  ),
  
  
  Question(
    text: "How much do you enjoy car rides?",
    type: .ranged,
    answers: [
      Answer(text: "I dislike them", type: .cat),
      Answer(text: "I get a little nervous", type: .rabbit),
      Answer(text: "I barely notice them", type: .turtle),
      Answer(text: "I love them", type: .dog)
    ]
  )
]
