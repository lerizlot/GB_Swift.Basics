import UIKit

/*
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль.
 */

enum EngineState {
    case running, stopped
}
enum WindowsState {
    case opened, closed
}

enum Color {
    case blue, yellow, green, red
}

enum HandleAction {
    case runEngine, stopEngine, openWindows, closeWindows, loadCargo(Int), unloadCargo(Int)
}

// 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
protocol Car {
    var color: UIColor { get set }
    var year: UInt { get set }
    var trunkVolume: UInt { get set }
    var engineState: EngineState { get set }
    var windowsState: WindowsState { get set }
    var filledTrunkVolume: Int { get set }
    
    func handleAction(action: HandleAction)
}

// 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
extension Car {
    mutating func checkWindows() {
        switch self.windowsState {
        case .opened:
            self.windowsState = .opened
        case .closed:
            self.windowsState = .closed
        }
    }
}

extension Car {
    mutating func checkEngine() {
        switch self.engineState {
        case .running:
            self.engineState = .running
        case .stopped:
            self.engineState = .stopped
        }
    }
}

extension Car {
    mutating func loadCargo(weight: Int) {
        print("You are going to load \(weight) kg of cargo.")
        let guardCargo = self.filledTrunkVolume + weight
        guard  guardCargo < trunkVolume else {
            return print("You can't load this cargo, the trunk is full. \n Operation won't be processed!")
        }
        self.filledTrunkVolume += weight
        print("After the cargo loaded, your trunk capacity is \(guardCargo)")
    }
}

extension Car {
    mutating func unloadCargo(weight: Int) {
        print("You are going to unload \(weight) from the trunk.")
        let guardCargo = self.filledTrunkVolume - weight
        guard  guardCargo > 0 else {
            return print("You are trying to unload unavaliable volume of cargo \n Operation won't be processed!")
        }
        self.filledTrunkVolume -= weight
        print("After the unload, your trunk capacity is \(guardCargo)")
    }
}

//Задание 3
//Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
class SportCar: Car {
    
    func handleAction(action: HandleAction) {}
    
    var color: UIColor
    var year: UInt
    var trunkVolume: UInt
    var filledTrunkVolume: Int
    var windowsState: WindowsState
    var engineState: EngineState
    var maxSpeed: UInt
    var isTurboOn: Bool
    
    init(color: UIColor, year: UInt, trunkVolume: UInt, ngineState: EngineState, windowsState: WindowsState, filledTrunkVolume: Int, maxSpeed: UInt, isTurboOn: Bool) {
        self.color = color
        self.year = year
        self.trunkVolume = trunkVolume
        self.engineState = .running
        self.windowsState = .opened
        self.filledTrunkVolume = filledTrunkVolume
        self.maxSpeed = maxSpeed
        self.isTurboOn = isTurboOn
    }
}

class TrunkCar: Car {
    
    func handleAction(action: HandleAction) {}
    
    var color: UIColor
    var year: UInt
    var trunkVolume: UInt
    var engineState: EngineState
    var windowsState: WindowsState
    var filledTrunkVolume: Int
    
    var isRefrigeratorOn: Bool
    var isTrailerAttached: Bool
    
    init(color: UIColor, year: UInt, trunkValue: UInt, engineState: EngineState, windowsState: WindowsState, filledTrunkVolume: Int, isRefrigeratorOn: Bool, isTrailerAttached: Bool) {
        self.color = color
        self.year = year
        self.trunkVolume = trunkVolume
        self.engineState = .stopped
        self.windowsState = .closed
        self.filledTrunkVolume = filledTrunkVolume
        
        self.isTrailerAttached = isTrailerAttached
        self.isRefrigeratorOn = isRefrigeratorOn
    }
}

//Задание 4
//Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
extension SportCar: CustomStringConvertible {
    var description: String {
        return """
                 #####
                    Color: \(self.color)
                    Year: \(self.year)
                    Engine state: \(self.engineState)
                    Windows state: \(self.windowsState)
                    Turbo state: \(self.isTurboOn)
                 #####
                """
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        return """
                 #####
                    Color: \(self.color)
                    Year: \(self.year)
                    Engine state: \(self.engineState)
                    Windows state: \(self.windowsState)
                    Trailer state: \(self.isTrailerAttached)
                 #####
                """
    }
}
//Задание 5
//Создать несколько объектов каждого класса. Применить к ним различные действия.
var audi = SportCar(color: .red, year: 2010, trunkVolume: 300, ngineState: .running, windowsState: .opened, filledTrunkVolume: 240, maxSpeed: 250, isTurboOn: true)

var porsche = TrunkCar(color: .yellow, year: 2005, trunkValue: 50000, engineState: .stopped, windowsState: .opened, filledTrunkVolume: 15000, isRefrigeratorOn: false, isTrailerAttached: true)

audi.loadCargo(weight: 130)
audi.windowsState
audi.engineState

porsche.unloadCargo(weight: 500)
porsche.windowsState
porsche.engineState


print(audi.description)
print(porsche.description)
