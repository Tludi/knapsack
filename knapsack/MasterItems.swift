//
//  MasterItems.swift
//  knapsack
//
//  Created by Timothy Ludi on 8/1/15.
//  Copyright (c) 2015 diligentagility. All rights reserved.
//

import Foundation

struct CategoryList {
  var category: String
  var items: [String]
}


class MasterItemList {

  let categories: [String] = [
    "clothing",
    "toiletries",
    "electronics",
    "documents",
    "financial",
    "medical",
    "food",
    "miscellaneous",
    "camping"
//    "international",
//    "beach",
//    "hiking",
//    "children",
//    "infants",
//    "carry on luggage"
  ]

  let itemList: [String:[String]] = [
    "clothing": [
      "Casual Shirts",
      "T-Shirts",
      "Casual Pants",
      "Shorts",
      "Dress Shirts",
      "Dress Pants",
      "Pajamas",
      "Robe",
      "Slippers",
      "Sweaters",
      "Underwear",
      "Socks",
      "Tennis Shoes",
      "Sandals",
      "Dress Shoes",
      "Hats",
      "Scarves",
      "Gloves",
      "Belts",
      "Jackets/Coats",
      "Swimwear",
      "Workout Clothes",
      "Suits",
      "Sport Coats",
      "Ties",
      "Skirts",
      "Dresses",
      "Bras"
    ],
    "toiletries": [
      "Toothbrush",
      "Toothpaste",
      "Dental Floss/Picks",
      "Mouthwash/Rinse",
      "Cotton Swabs",
      "Cotton Balls",
      "Tissues",
      "Nail Clippers",
      "Tweezers",
      "Deodorant",
      "Shampoo",
      "Conditioner",
      "Bar Soap",
      "Washcloth",
      "Brush/Comb",
      "Hair Spray",
      "Mirror",
      "Lotion",
      "Lip Balm",
      "Razor",
      "Shaving Cream/Gel",
      "Cologne",
      "Aftershave",
      "Cosmetics",
      "Feminine Products",
      "Curling Iron",
      "Hair Dryer",
      "Hair Accessories",
      "Perfume"
    ],
    "electronics": [
      "Cellphone",
      "Cellphone Charger",
      "Tablet",
      "Tablet Charger",
      "Laptop",
      "Mouse",
      "Headphones",
      "Camera",
      "Batteries",
      "Memory Card",
      "Watch",
      "Music",
      "Exercise Monitor",
      "Exercise Monitor Charger"
    ],
    "documents": [
      "Drivers License/ID",
      "Passport",
      "Visa",
      "Travel Itinerary",
      "Hotel Reservations",
      "Boarding Pass",
      "Tickets",
      "Maps",
      "Guide Books",
      "Reading Books",
      "Notebooks/Pens",
      "Business Cards"
    ],
    "financial": [
      "Wallet",
      "Purse",
      "Credit Card",
      "Debit Card",
      "Company Credit Card",
      "Cash"
    ],
    "medical": [
      "Prescriptions",
      "Allergy Medication",
      "First Aid Kit",
      "Vitamins",
      "Hand Wipes",
      "Hand Sanitizer",
      "Pain Medication",
      "Eye Drops",
      "Motion Sickness Medication"
    ],
    "food": [
      "Granola Bars",
      "Protein Bars",
      "Oatmeal Packets",
      "Dried Fruit",
      "Nuts",
      "Water"
    ],
    "miscellaneous": [
      "Travel Iron",
      "Travel Locks",
      "Earplugs",
      "Umbrella",
      "Keys"
    ],
    "camping": [
      "Tent",
      "Sleeping Bag",
      "Tarp",
      "Foam Pad",
      "Camp Shovel",
      "Cooler",
      "Firewood",
      "Matches",
      "Camp Stove",
      "Propane",
    ]
  ] // end itemList

}







