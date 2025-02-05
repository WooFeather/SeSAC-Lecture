//
//  PersonViewModel.swift
//  SeventhWeek
//
//  Created by 조우현 on 2/5/25.
//

import Foundation

class PersonViewModel {
    
    var inputLoadButtonTapped: Observable<Void> = Observable(())
    
    // VC의 TV에 보여줄 데이터
    var people: Observable<[Person]> = Observable([])
    let navigationTitle = "Person List"
    let loadTitle = "로드버튼"
    let resetTitle = "리셋버튼"
    
    init() {
        inputLoadButtonTapped.bind { _ in
            self.people.value = self.generateRandomPeople()
        }
    }
    
    private func generateRandomPeople() -> [Person] {
        return [
            Person(name: "James", age: Int.random(in: 20...70)),
            Person(name: "Mary", age: Int.random(in: 20...70)),
            Person(name: "John", age: Int.random(in: 20...70)),
            Person(name: "Patricia", age: Int.random(in: 20...70)),
            Person(name: "Robert", age: Int.random(in: 20...70))
        ]
    }
}
