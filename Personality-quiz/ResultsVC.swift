//
//  ResultsVC.swift
//  Personality-quiz
//
//  Created by Olibo moni on 25/11/2021.
//

import UIKit

class ResultsVC: UIViewController {
    var responses: [Answer]
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultAnswerDefinition: UILabel!
    
    
    init?(coder: NSCoder, responses: [Answer]){
        self.responses = responses
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResults()
        navigationItem.hidesBackButton = true

        
    }
    
    func calculatePersonalityResults(){
        let frequencyOfAnswer = responses.reduce(into: [:]) {  (counts, answer) in
            counts[answer.type, default: 0] += 1
            
        }
        print(frequencyOfAnswer)
        //let frequencyAnswersSorted = frequencyOfAnswer.sorted { pair1, pair2 in
            //return pair1.value > pair2.value }
        
        let mostCommonAnswer = frequencyOfAnswer.sorted { $0.1 > $1.1 }.first!.key
        resultAnswerLabel.text = "You're a \(mostCommonAnswer.rawValue)"
        resultAnswerDefinition.text = mostCommonAnswer.definition
        
    }

    //func updateUI(){
        
    //}
    
}
