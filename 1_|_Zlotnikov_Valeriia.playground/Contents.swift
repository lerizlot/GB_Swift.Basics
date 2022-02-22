import Foundation

/*
1. Решить квадратное уравнение.
2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
*/

//1. Решить квадратное уравнение ax2 + bx + c = 0
let a:Double = 3
let b:Double = 15
let c:Double = 8
let Descriminant = (b * b) - (4 * a * c) // находим дискриминант
if Descriminant>0{
let x1 = (-b - sqrt(Descriminant)) / (2 * a) //находим х1
let x2 = (-b + sqrt(Descriminant)) / (2 * a) // находим х2
print ("Значение x1 = \(x1)\nЗначение x2 = \(x2)")

} else if Descriminant == 0{
    let x = -b / 2 * a //находим х
    print("Значение x = \(x)")
} else if Descriminant < 0 {
    print("Дискриминант меньше 0, уравнение не имеет действительных решений")
}

//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
// S=​(1/2) * a*b     a2+b2=c2 - гипотенуза
let katetA:Double = 15
let katetB:Double = 10
let ploshad = (1 / 2) * (katetA * katetB) //вычисляем площадь
let hypotenuse = (katetA*katetA) + (katetA*katetA) //находим гипотенузу
let TrueHypotenuse = Int(sqrt(hypotenuse))
let perimetr = Double (TrueHypotenuse) + katetA + katetB // периметр

print ("периметр треугольника = \(perimetr)")
print ("площадь треугольника = \(ploshad)")
print ("гипотенуза треугольника = \(TrueHypotenuse)")

//3. * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
print ("Введи сумму депозита")
let deposit = Double (readLine()!)!  // вводим сумму депозита
print ("Введите процентную ставку")
let procent = Double (readLine()!)! // вводим процент вклада
print ("Укажите срок депозита в годах")
let term = Double (readLine()!)!  //вводим срок депозита в годах
if term == 1 || term == 2 || term == 3 || term == 4  {
print ("Всего за \(term) год, вы заработали \((deposit * (procent / 100) * term)+deposit)")
}
else {
    print ("Всего за \(term) лет, вы заработали \((deposit * (procent / 100) * term)+deposit)")
}
