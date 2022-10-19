//
//  main.swift
//  home work 2.1
//
//  Created by Айбек Шакиров on 17/10/22.
//

import Foundation
/2 месяц. ДЗ #1

//1. Создать класс "Машина"(Car) и задать ему свойства
//Создать функцию, которая будет увеличивать мощность авто(тюнинг по всем параметрам)

class Car{
    let mark: String
    var maxSpeed: Int
    var volume: Double
    
    
    
    init(mark: String, maxSpeed: Int, volume: Double){
        self.mark = mark
        self.maxSpeed = maxSpeed
        self.volume = volume
    }
    
    func tuneCar(){
        self.maxSpeed += 100
        self.volume += 0.2
    }
}


let bmw = Car(mark: "BMW", maxSpeed: 200, volume: 3.2)
bmw.maxSpeed //200
bmw.volume //3.2
bmw.tuneCar()
bmw.volume //3.4
bmw.maxSpeed //300



//2. Создать класс "Магазин" и "Продукт" и задать им свойства
//Также создать функцию добавления продукта в магазин и отображения товаров в магазине


class Shop{
    let shopName: String
    var products: [Product] = [Product]()
    
    
    
    init(shopName: String){
        self.shopName = shopName
    }
    
    func addToCart(product: Product){
        self.products.append(product)
    }
    
    func showInfo(){
        for product in products {
            print("Наименование продукта: \(product.productName). Цена (шт.) \(product.productPrice). Количество продуктов: \(product.productQuantity)")
        }
    }
}

class Product{
    let productName: String
    var productPrice: Int
    var productQuantity: Int
    
    init(productName: String, productPrice: Int, productQuantity: Int){
        self.productName = productName
        self.productPrice = productPrice
        self.productQuantity = productQuantity
    }
}

let mango = Product(productName: "mango", productPrice: 150, productQuantity: 2)
let shop = Shop(shopName: "AsiaMall")
shop.addToCart(product: mango)
shop.showInfo()


//3. Создать класс "Банк" и "Клиент"
//создать функции для:
//1) Подсчета клиентов банка
//2) Отображения баланса по ID или фамилии клиента
//3) Перевода средств от клиента к другому клиенту

class Bank{
    let bankName:String
    var customers = [Customer]()
    
    init(bankName:String){
        self.bankName = bankName
    }
    
    func showCustomersQuantity(){
        print("Количество клиентов в банке \"\(self.bankName)\": \(customers.count)")
    }
    
    func addCustomer(customer: Customer){
        customers.append(customer)
    }
}

class Customer{
    var balance: Int
    let id: Int
    let customerName: String
    let customerSurname: String
    
    
    init(balance:Int, id:Int, customerName:String, customerSurname: String, customersBank: Bank){
        self.balance = balance
        self.id = id
        self.customerName = customerName
        self.customerSurname = customerSurname
        customersBank.addCustomer(customer: self)
    }
    
    func showCustomerInfo(id: Int){
        if id == self.id{
            print("Баланс клиента с ID \(id) составляет \(self.balance) KGS")
        } else{
            print("Not found id in database.")
        }
    }
    
    func showCustomerInfo(customerSurname: String){
        if customerSurname == self.customerSurname{
            print("Баланс клиента \(self.customerName) \(self.customerSurname) составляет \(self.balance) KGS")
        } else {
            print("Not found customer's data in database.")
        }
    }
    
    func makeTransaction(to receiver: Customer, quantity: Int){
        if self.balance >= quantity{
            self.balance -= quantity
            receiver.balance += quantity
            print("Баланс пользователя с ID \(receiver.id) успешно пополнен на \(quantity) KGS. Ваш текущий баланс: \(self.balance)")
        } else {
            print("Недостаточно средств! Пополните баланс!")
        }
    }
}


let optima = Bank(bankName: "Optima Bank")
optima.showCustomersQuantity() //0

let customerOne = Customer(balance: 5000, id: 1202, customerName: "Ivan", customerSurname: "Ivanov", customersBank: optima)
optima.showCustomersQuantity() //1

customerOne.showCustomerInfo(id: 1202)


let customerTwo = Customer(balance: 10000, id: 1202, customerName: "Azamat", customerSurname: "Azamatov", customersBank: optima)

optima.showCustomersQuantity() //2
customerOne.makeTransaction(to: customerTwo, quantity: 1000)
customerTwo.balance //11000
