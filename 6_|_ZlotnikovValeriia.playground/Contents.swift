import UIKit

/*
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
 */

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
struct Queue<QueueT> {
    var list = [QueueT]()
    
    mutating func enqueueInCollection(_ element: [QueueT]) {
        list.append(contentsOf: element)
    }
    
    mutating func dequeueFromCollection() -> QueueT? {
        let resultDequeue = !list.isEmpty ? list.removeFirst() : nil
        return resultDequeue
    }
    
    func showFirstElement() -> QueueT? {
        let resultPeek = !list.isEmpty ? list[0] : nil
        return resultPeek
    }
    
    var statusIsEmpty: String {
        let resultIsEmpty = list.isEmpty ? "Queue is free" : "Queue is full: \(list)"
        print(resultIsEmpty)
        return resultIsEmpty
    }
}

//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
extension Queue {
    func filter(predicate: (QueueT) -> Bool) -> [QueueT] {
        var result = [QueueT]()
        for element in list {
            if predicate(element) {
                result.append(element)
            }
        }
        return result
    }

//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
    
    subscript(elements: Int) -> String? {
            var answer = ""
            if elements > list.count - 1 {
                return nil
            } else {
                answer = "\(list[elements])"
            }
            return answer
        }
}

var queueCollection = Queue<Int>()
queueCollection.enqueueInCollection([1])
queueCollection.enqueueInCollection([2])
queueCollection.enqueueInCollection([3])
queueCollection.enqueueInCollection([4])
queueCollection.enqueueInCollection([5])


queueCollection.dequeueFromCollection()
queueCollection.showFirstElement()
queueCollection.statusIsEmpty

let filterQueueCollection = queueCollection.filter{$0 % 2 == 0}
let sorted = queueCollection.list.sorted(by: >)

queueCollection[4]
