# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Person.delete_all

# Users
User.create(
    [{
        name: 'John',
        fields: {
            person:{
                number: {
                    name: 'Number',
                    type: 'integer',
                    is_filter_exist: true,
                    is_sort_exist: true
                },
                city: {
                    name: 'City',
                    type: 'string',
                    is_filter_exist: true,
                    is_sort_exist: true
                },
                country: {
                    name: 'Country',
                    type: 'string',
                    is_filter_exist: false,
                    is_sort_exist: false
                }
            }
        }
     },
    {
        name: 'Joe',
        fields: {
            person:{
                phone: {
                    name: 'Phone',
                    type: 'string',
                    is_filter_exist: true,
                    is_sort_exist: true
                },
                order: {
                    name: 'Order',
                    type: 'integer',
                    is_filter_exist: false,
                    is_sort_exist: false
                },
                hobies: {
                    name: 'Hobies',
                    type: 'string',
                    is_filter_exist: true,
                    is_sort_exist: true
                }
            }
        }
     }]
)


# People
Person.create(
    [{
        name: 'John',
        surname: 'May',
        metadata: {
            number: 40,
            city: 'Antalya',
            country: 'Turkey'
        }
     },{
        name: 'Nab',
        surname: 'Kul',
        metadata: {
            number: 100,
            city: 'Denizli',
            country: 'Turkey'
        }
     },{
        name: 'Ahmet',
        surname: 'Kulak',
        metadata: {
            number: 76,
            city: 'Denizli',
            country: 'Turkey'
        }
     },{
        name: 'Ali',
        surname: 'Kul',
        metadata: {
            phone: 905004002244,
            order: 1,
            hobies: 'Sport, Music'
        }
    },{
        name: 'Veli',
        surname: 'Lalo',
        metadata: {
            phone: 905003007666,
            order: 1,
            hobies: 'Coding, Walking'
        }
    },{
        name: 'Ayşe',
        surname: 'Zal',
        metadata: {
            phone: 905004002244,
            order: 1,
            hobies: 'Sport, Music, Code, Computer, Walking'
        }
     }]
)
