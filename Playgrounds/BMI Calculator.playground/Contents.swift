import UIKit

func CalculateBMI(weight : Float, height : Float) -> String {
    let bmi = weight / (height * height)
    
    if bmi > 25 {
        return "Your BMI is \(bmi). You are overweight!! Take care buddy ;)"
    }
    else if bmi > 18 {
        return "Your BMI is \(bmi). You are quite well! Keep it up."
    }
    else {
        return "Your BMI is \(bmi). You are underweight :(. Be careful or you'll get sick."
    }
}

print(CalculateBMI(weight : 50, height : 1.75))
