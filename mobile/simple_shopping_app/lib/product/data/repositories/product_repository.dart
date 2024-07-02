import '../model/product_model.dart';

class ProductRepository {
  final List<ProductModel> _products = [
    ProductModel(
      id: 1,
      category: "Drinks and Beverages",
      price: 44800,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSynwPbrsys0b-9xjytW6tQVd1iDQS9gXiU1w&s",
      name: "Jameson Irish Whiskey",
      quantity: 10,
    ),
    ProductModel(
      id: 2,
      category: "Drinks and Beverages",
      price: 24000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4UJrHw2sceuafa-ZdtPX9Kczf5uNTHnlnMw&s",
      name: "Jack Daniels",
      quantity: 10,
    ),
    ProductModel(
      id: 3,
      category: "Drinks and Beverages",
      price: 90000,
      image:
          "https://www.myminibar.ng/cdn/shop/products/add54673-2e32-405e-b31c-fe7602244ce9-1.png?v=1624563841",
      name: "Telling Whishkey",
      quantity: 10,
    ),
    ProductModel(
      id: 4,
      category: "Drinks and Beverages",
      price: 50000,
      image:
          "https://crownwineandspirits.com/cdn/shop/products/woodford-reserve-bourbon-woodford-reserve-kentucky-straight-bourbon-whiskey-750ml-31515728543837.jpg?v=1664303533",
      name: "Woodford Bourbon whiskey",
      quantity: 10,
    ),
    ProductModel(
      id: 5,
      category: "Drinks and Beverages",
      price: 38000,
      image:
          "https://applejack.com/site/images/Makers-Mark-46-Kentucky-Bourbon-Whiskey-750-ml_1.png",
      name: "Makers Mark Whiskey",
      quantity: 10,
    ),
    ProductModel(
      id: 6,
      category: "Drinks and Beverages",
      price: 15000,
      image:
          "https://thewhiskeyreserve.com/cdn/shop/files/Baileys-Irish-Whiskey.jpg?v=1686912829",
      name: "Baileys Irish Whiskey",
      quantity: 10,
    ),
    ProductModel(
      id: 7,
      category: "Drinks and Beverages",
      price: 120000,
      image:
          "https://limestonebranch.com/wp-content/uploads/2023/08/Bottle-with-Glass-1-scaled.jpg",
      name: "Rye Whiskey",
      quantity: 10,
    ),
    ProductModel(
      id: 8,
      category: "Drinks and Beverages",
      price: 18000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7iojEz3TKFjfFB1RgaQH_ruOtzrbKJO8PUg&s",
      name: "Sky Vodka",
      quantity: 10,
    ),
    ProductModel(
      id: 9,
      category: "Drinks and Beverages",
      price: 17000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1CsIQCrVZfaS9j76ERoiujsU19daovCiZfw&s",
      name: "Smirnoff Red White",
      quantity: 10,
    ),
    ProductModel(
      id: 10,
      category: "Drinks and Beverages",
      price: 21000,
      image:
          "https://drymartiniorg.com/wp-content/uploads/2015/11/Los_origenes_del_vodka_Dry_Martini_JAvier_de_las_Muelas.jpg",
      name: "Dry martini",
      quantity: 10,
    ),
    ProductModel(
      id: 11,
      category: "Apparels and Wears",
      price: 18000,
      image:
          "https://media.gq.com/photos/5e5d79123cd32e0008c31f20/16:9/w_2560%2Cc_limit/what-to-wear-now-models-gq-style-spring-summer-2020-lede.jpg",
      name: "Spring Suit",
      quantity: 10,
    ),
    ProductModel(
        id: 12,
        category: "Apparels and Wears",
        price: 12000,
        image:
            "https://image.made-in-china.com/202f0j00cbFGBavdlUon/The-New-2021-Trailing-Dress-Skirt-of-The-Girls-Children-Designer-Clothes-Infants-Designer-Clothing-Kids-Party-Wear-Dresses-Baby-Girl-Garment-Wedding-Apparel.jpg",
        name: "Cute pricess",
        quantity: 10),
    ProductModel(
      id: 13,
      category: "Apparels and Wears",
      price: 8000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIA2PsGu4ai51aea80rpZe6lpOnvARawUVCw&s",
      name: "Couples top",
      quantity: 10,
    ),
    ProductModel(
      id: 14,
      category: "Apparels and Wears",
      price: 10000,
      image:
          "https://media.glamour.com/photos/5f24358ef1a7b465f3f32ff0/master/w_2560%2Cc_limit/GettyImages-514355460.jpg",
      name: "Winter hoodie",
      quantity: 10,
    ),
    ProductModel(
      id: 15,
      category: "Apparels and Wears",
      price: 12000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHBmwZ9xlVUCHP0aeSo5sSItYyswXdMEPeDQ&s",
      name: "Sport apparel",
      quantity: 10,
    ),
    ProductModel(
      id: 16,
      category: "Apparels and Wears",
      price: 12500,
      image:
          "https://www.byrdie.com/thmb/EisU1fM6spV5fmoJ2w5Gb1vG2zs=/1500x0/filters:no_upscale():max_bytes(200000):strip_icc()/05_ClothingApparel_STYLE_Mobile-e3959b24adb14e32b5fc1a3ab03ec0c8.jpg",
      name: "Angels gaze",
      quantity: 10,
    ),
    ProductModel(
      id: 17,
      category: "Apparels and Wears",
      price: 7000,
      image:
          "https://apparelglobal.com/en/wp-content/uploads/2023/07/the-best-summer-dresses-for-a-stylish-wardrobe-img-1.webp",
      name: "Summer Casual",
      quantity: 10,
    ),
    ProductModel(
      id: 18,
      category: "Apparels and Wears",
      price: 11000,
      image:
          "https://thesynerg.com/wp-content/uploads/2023/04/How-clothing-affects-behaviour-and-how-fashion-apparel-affects-the-social-perception-Synerg.jpg",
      name: "Oblivion",
      quantity: 10,
    ),
    ProductModel(
      id: 19,
      category: "Apparels and Wears",
      price: 12000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuD8aXyh6H3wh9nyj1S7NOKUFpNfggIJAiPQ&s",
      name: "India Sari",
      quantity: 10,
    ),
    ProductModel(
        id: 20,
        category: "Apparels and Wears",
        price: 40000,
        image:
            "https://media.glamour.com/photos/5cfae2466d2a7a456e43271a/master/w_2560%2Cc_limit/GettyImages-1153522272.jpg",
        name: "Women Office suit",
        quantity: 10),
    ProductModel(
      id: 21,
      category: "Electronics and Devices",
      price: 12000,
      image:
          "https://t3.ftcdn.net/jpg/01/34/14/20/360_F_134142098_35jEUodu2IkWtppO53abj0KYijvnvCNo.jpg",
      name: "Electronic Speaker",
      quantity: 10,
    ),
    ProductModel(
      id: 22,
      category: "Electronics and Devices",
      price: 800000,
      image:
          "https://www.apple.com/newsroom/images/product/iphone/geo/Apple-iPhone-14-iPhone-14-Plus-hero-220907-geo.jpg.news_app_ed.jpg",
      name: "Iphone 14 plus",
      quantity: 10,
    ),
    ProductModel(
      id: 23,
      category: "Electronics and Devices",
      price: 160000,
      image:
          "https://ng.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/40/797354/2.jpg?8224",
      name: "Samsung 32 inches LED TV",
      quantity: 10,
    ),
    ProductModel(
      id: 24,
      category: "Electronics and Devices",
      price: 720000,
      image:
          "https://powermaccenter.com/cdn/shop/files/iPhone_14_Yellow_PDP_Image_Position-1A__en-US_0695e8c6-77b7-4ee2-a2e4-360fd972281b.jpg?v=1705405593",
      name: "Iphone 14 128gb",
      quantity: 10,
    ),
    ProductModel(
      id: 25,
      category: "Electronics and Devices",
      price: 120000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLcYu1d6vSa_mDZzpvclNsmFKH_7jr7J043A&s",
      name: "LG Washing Maching",
      quantity: 10,
    ),
    ProductModel(
      id: 26,
      category: "Electronics and Devices",
      price: 12000,
      image:
          "https://t3.ftcdn.net/jpg/01/34/14/20/360_F_134142098_35jEUodu2IkWtppO53abj0KYijvnvCNo.jpg",
      name: "Electronic Speaker",
      quantity: 10,
    ),
    ProductModel(
      id: 27,
      category: "Electronics and Devices",
      price: 500000,
      image:
          "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/macbookair-og-202402?wid=1200&hei=630&fmt=jpeg&qlt=95&.v=1707414684423",
      name: "MacBook Air M3",
      quantity: 10,
    ),
    ProductModel(
      id: 28,
      category: "Electronics and Devices",
      price: 350000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTapgv69e_O-F6V7tr-1Rnr1uNgHzkAY4tuRA&s",
      name: "Two side Washing Machine",
      quantity: 10,
    ),
    ProductModel(
      id: 29,
      category: "Electronics and Devices",
      price: 160000,
      image:
          "https://ng.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/40/797354/2.jpg?8224",
      name: "Samsung 32 inches LED TV",
      quantity: 10,
    ),
    ProductModel(
      id: 30,
      category: "Electronics and Devices",
      price: 12000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLcYu1d6vSa_mDZzpvclNsmFKH_7jr7J043A&s",
      name: "LG Washing Maching",
      quantity: 10,
    ),
    ProductModel(
      id: 31,
      category: "Food and Snacks",
      price: 12000,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Lj3_8eh0xYQLDhyh1pYwOF6l00mL7hIfww&s",
      name: "Classic Cheese Pizza",
      quantity: 10,
    ),
    ProductModel(
      id: 32,
      category: "Food and Snacks",
      price: 15000,
      image:
          "https://www.allrecipes.com/thmb/D73VvwH_cG06pVzh05oitTocYV8=/0x512/filters:no_upscale():max_bytes(150000):strip_icc()/48727-Mikes-homemade-pizza-DDMFS-beauty-4x3-BG-2974-a7a9842c14e34ca699f3b7d7143256cf.jpg",
      name: "Mikes Pizza",
      quantity: 10,
    ),
    ProductModel(
      id: 33,
      category: "Food and Snacks",
      price: 8000,
      image:
          "https://www.recipetineats.com/tachyon/2023/05/Garlic-cheese-pizza_9.jpg",
      name: "Garlic Cheese Pizza",
      quantity: 10,
    ),
    ProductModel(
      id: 34,
      category: "Food and Snacks",
      price: 6900,
      image: "https://i.ytimg.com/vi/uYUB5E-13bE/maxresdefault.jpg",
      name: "Crispy Chicken Sharwarma",
      quantity: 10,
    ),
    ProductModel(
      id: 35,
      category: "Food and Snacks",
      price: 10000,
      image:
          "https://www.thedailymeal.com/img/gallery/what-a-beginner-needs-to-know-about-ordering-shawarma/l-intro-1681948540.jpg",
      name: "Double Sized Beef Sharwarma",
      quantity: 10,
    ),
    ProductModel(
      id: 36,
      category: "Food and Snacks",
      price: 12000,
      image:
          "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/how-to-barbecue-safely-main-image-700-350-cb858be.jpg",
      name: "Crris BBQ",
      quantity: 10,
    ),
    ProductModel(
      id: 37,
      category: "Food and Snacks",
      price: 12800,
      image:
          "https://cdn2.hubspot.net/hubfs/334586/Blog/BBQ%20chix%20on%20grill.jpg",
      name: "Chicken BBQ",
      quantity: 10,
    ),
    ProductModel(
      id: 38,
      category: "Food and Snacks",
      price: 18000,
      image:
          "https://www.craftycookbook.com/wp-content/uploads/2024/04/nigiri-sushi-1200.jpg",
      name: "Nigiri Sushi",
      quantity: 10,
    ),
    ProductModel(
      id: 39,
      category: "Food and Snacks",
      price: 20000,
      image:
          "https://t4.ftcdn.net/jpg/06/65/75/07/360_F_665750708_FhXMnTL7Zwe9TNqCWfy9mVOJz3INqmqN.jpg",
      name: "Double Decker Burger",
      quantity: 10,
    ),
    ProductModel(
      id: 40,
      category: "Food and Snacks",
      price: 17380,
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShdmf2Nk42kj_2rq_2mdqNDGvfDwwIpXQo1g&s",
      name: "Burger King Meat Monster",
      quantity: 10,
    ),
  ];

  List<ProductModel> getProducts() {
    return _products;
  }
}
