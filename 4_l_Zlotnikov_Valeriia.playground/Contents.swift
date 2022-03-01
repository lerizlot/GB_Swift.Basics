import UIKit

/*
1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
5. Создать несколько объектов каждого класса. Применить к ним различные действия.
6. Вывести значения свойств экземпляров в консоль.
*/

// 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
enum EngineState: String {
    case on = "is on"
    case off = "is off"
}

enum WindowsState: String {
    case opened = "are opened"
    case closed = "are closed"
}

enum CargoAction {
    case load(weight: Double)
    case unload(weight: Double)
}

enum TurboState: String {
    case on = "is on"
    case off = "is off"
}

enum CarActions {
    case changeEngineState(state: EngineState)
    case changeWindowsState(state: WindowsState)
    case changeTrunkVolumeState(action: CargoAction)
    case changeTurboState(action: TurboState)
}

// 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
class Car {
    var brand: String
    var year: UInt
    var engineState: EngineState
    var windowsState: WindowsState
    static var carsCount = 0

    init(brand: String, year: UInt, engineState: EngineState = .off, windowsState: WindowsState = .closed) {
        self.brand = brand
        self.year = year
        self.engineState = engineState
        self.windowsState = windowsState

        Car.carsCount += 1
    }

    deinit {
        Car.carsCount -= 1
    }

    func printInfo() {
        print("This car is a \(self.brand) issued in \(self.year) year. Engine status - \(self.engineState.rawValue), windows status - \(self.windowsState.rawValue).")
    }

    func emitAction(action: CarActions) {}
}

// 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
class SportCar: Car {
    var turboState: TurboState

    init(brand: String, year: UInt, turboState: TurboState = .on, engineState: EngineState = .off, windowsState: WindowsState = .closed) {
        self.turboState = turboState
        super.init(brand: brand, year: year, engineState: engineState, windowsState: windowsState)
    }

    override func printInfo() {
        print("This car is a \(self.brand), issued in \(self.year) year. Engine   \(self.engineState.rawValue) , windows \(self.windowsState.rawValue), turbo   \(self.turboState.rawValue).")
    }

// 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
    
    override func emitAction(action: CarActions) {
        switch action {
        case .changeWindowsState(state: let state):
            self.windowsState = state
        case .changeEngineState(state: let state):
            self.engineState = state
        case .changeTurboState(action: let turboState):
            self.turboState = turboState
        default:
            print("This \(self.brand) doesn't support this feature!")
        }
    }
}

class TruckCar: Car {
    var trunkVolume: Double
    var filledTrunkVolume: Double
    var freeTrunkSpace: Double {
        return trunkVolume - filledTrunkVolume
    }

    init(brand: String, year: UInt, trunkVolume: Double, filledTrunkVolume: Double = 0, engineState: EngineState = .off, windowsState: WindowsState = .closed) {
        self.trunkVolume = trunkVolume
        self.filledTrunkVolume = filledTrunkVolume
        super.init(brand: brand, year: year, engineState: engineState, windowsState: windowsState)
    }

    override func printInfo() {
        print("This car is a \(self.brand), issued in \(self.year) year. Engine \(self.engineState.rawValue), windows \(self.windowsState.rawValue), the maxumum trunk volume is \(self.trunkVolume) kg, at this moment filled trunk volume is \(self.filledTrunkVolume) kg.")
    }

// 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
    
    override func emitAction(action: CarActions) {
        switch action {
        case .changeWindowsState(state: let state):
            self.windowsState = state
        case .changeEngineState(state: let state):
            self.engineState = state
        case .changeTrunkVolumeState(action: let trunkAction):
            switch trunkAction {
            case .load(weight: let weight):
                if weight > self.freeTrunkSpace {
                    print("\(filledTrunkVolume + weight - self.trunkVolume)")
                    self.filledTrunkVolume = self.trunkVolume
                } else {
                    self.filledTrunkVolume += weight
                }
            case .unload(weight: let weight):
                if self.filledTrunkVolume - weight < 0 {
                    self.filledTrunkVolume = 0
                } else {
                    self.filledTrunkVolume -= weight
                }
            }
        default:
            print("This \(self.brand) doesn't support tis feature!")
        }
    }
}


// 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
var sportCar: SportCar? = SportCar(brand: "Porsche", year: 2009)
var truckCar: TruckCar? = TruckCar(brand: "RAW", year: 2016, trunkVolume: 1500)
print(Car.carsCount)

sportCar?.printInfo()
truckCar?.printInfo()
sportCar?.emitAction(action: .changeTurboState(action: .off))
truckCar?.emitAction(action: .changeTrunkVolumeState(action: .load(weight: 1000)))
sportCar?.printInfo()
truckCar?.printInfo()

//  6. Вывести значения свойств экземпляров в консоль.
sportCar = nil
print(Car.carsCount)
truckCar = nil
print(Car.carsCount)
