import 'package:flutter/material.dart';
import 'package:watch_admin/models/ListTiles.dart';
import 'package:watch_admin/models/category_model.dart';
import 'package:watch_admin/models/news_model.dart';
import 'package:watch_admin/models/product_model.dart';
import 'package:watch_admin/models/subcategory_model.dart';
import 'package:watch_admin/models/user.dart';
import 'package:watch_admin/models/vendor_model.dart';

List<ListTileModel> listTile = [
  ListTileModel("Products", 40, Icon(Icons.crop_square,color: Colors.teal,),Colors.teal),
  ListTileModel("Categories", 20, Icon(Icons.category,color: Colors.orange,),Colors.orange),
  ListTileModel("Vendors", 10, Icon(Icons.supervisor_account_rounded,color: Colors.grey,),Colors.grey),
  ListTileModel("Users", 50, Icon(Icons.chat,color: Colors.redAccent,),Colors.redAccent),
];

List<VendorModel> vendors = [
  VendorModel("Ali", "Nike", "ali@gmail.com", "+923456554356", "North Nazimabad Block 10", "Karachi", "7654", "Very good shoes", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREkC9FGf-H1Za-F-MNAF0THT_ccwcZHGpehA&usqp=CAU", "https://i.pinimg.com/736x/de/13/be/de13bedba8ab6783e2e460ff0e58e0a5.jpg", "password", "Active", "9 months ago"),
  VendorModel("Ali", "Nike", "ali@gmail.com", "+923456554356", "North Nazimabad Block 10", "Karachi", "7654", "Very good shoes", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREkC9FGf-H1Za-F-MNAF0THT_ccwcZHGpehA&usqp=CAU", "https://i.pinimg.com/736x/de/13/be/de13bedba8ab6783e2e460ff0e58e0a5.jpg", "password", "Active", "9 months ago"),
  VendorModel("Ali", "Nike", "ali@gmail.com", "+923456554356", "North Nazimabad Block 10", "Karachi", "7654", "Very good shoes", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREkC9FGf-H1Za-F-MNAF0THT_ccwcZHGpehA&usqp=CAU", "https://i.pinimg.com/736x/de/13/be/de13bedba8ab6783e2e460ff0e58e0a5.jpg", "password", "Active", "9 months ago"),
  VendorModel("Ali", "Nike", "ali@gmail.com", "+923456554356", "North Nazimabad Block 10", "Karachi", "7654", "Very good shoes", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREkC9FGf-H1Za-F-MNAF0THT_ccwcZHGpehA&usqp=CAU", "https://i.pinimg.com/736x/de/13/be/de13bedba8ab6783e2e460ff0e58e0a5.jpg", "password", "Active", "9 months ago"),
  VendorModel("Ali", "Nike", "ali@gmail.com", "+923456554356", "North Nazimabad Block 10", "Karachi", "7654", "Very good shoes", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREkC9FGf-H1Za-F-MNAF0THT_ccwcZHGpehA&usqp=CAU", "https://i.pinimg.com/736x/de/13/be/de13bedba8ab6783e2e460ff0e58e0a5.jpg", "password", "Active", "9 months ago"),
];

List<CategoryModel> categories = [
  CategoryModel("shoes", "https://i.pinimg.com/736x/de/13/be/de13bedba8ab6783e2e460ff0e58e0a5.jpg", "https://i.pinimg.com/736x/de/13/be/de13bedba8ab6783e2e460ff0e58e0a5.jpg", "Active"),
  CategoryModel("clothes", "https://images.unsplash.com/photo-1445205170230-053b83016050?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8Y2xvdGhpbmd8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80", "https://www.designmantic.com/logo-images/166857.png?company=Company+Name&slogan=&verify=1", "Active"),
];

List<SubCategoryModel> subCategories = [
  SubCategoryModel("Nike", "shoes", "https://i.pinimg.com/736x/de/13/be/de13bedba8ab6783e2e460ff0e58e0a5.jpg", "https://i.pinimg.com/736x/de/13/be/de13bedba8ab6783e2e460ff0e58e0a5.jpg", "Active"),
  SubCategoryModel("Zara","clothes", "https://images.unsplash.com/photo-1445205170230-053b83016050?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8Y2xvdGhpbmd8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&w=1000&q=80", "https://www.designmantic.com/logo-images/166857.png?company=Company+Name&slogan=&verify=1", "Active"),
];
//
// List<NewsModel> news = [
//   NewsModel("https://media.wired.com/photos/5ec2e4af31ea8dc988a4feef/master/w_2560%2Cc_limit/Thompson_2806.jpg", "The new startup", "Now you don't need to know any programming to launch a company. We've been approaching this moment for years", "6 months ago"),
//   NewsModel("https://media.wired.com/photos/5ec2e4af31ea8dc988a4feef/master/w_2560%2Cc_limit/Thompson_2806.jpg", "The new startup", "Now you don't need to know any programming to launch a company. We've been approaching this moment for years", "6 months ago"),
//   NewsModel("https://media.wired.com/photos/5ec2e4af31ea8dc988a4feef/master/w_2560%2Cc_limit/Thompson_2806.jpg", "The new startup", "Now you don't need to know any programming to launch a company. We've been approaching this moment for years", "6 months ago"),
//   NewsModel("https://media.wired.com/photos/5ec2e4af31ea8dc988a4feef/master/w_2560%2Cc_limit/Thompson_2806.jpg", "The new startup", "Now you don't need to know any programming to launch a company. We've been approaching this moment for years", "6 months ago")
// ];


List<ProductModel> products = [
  ProductModel("kick", "A very shoe to use", "shoes", "Nike", 2, "XL", 20, "featured", "30", "https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500", "In Stock"),
  ProductModel("kick", "A very shoe to use", "shoes", "Nike", 2, "XL", 20, "featured", "30", "https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500", "In Stock"),
  ProductModel("kick", "A very shoe to use", "shoes", "Nike", 2, "XL", 20, "featured", "30", "https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500", "In Stock"),
  ProductModel("kick", "A very shoe to use", "shoes", "Nike", 2, "XL", 20, "featured", "30", "https://images.pexels.com/photos/19090/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500", "In Stock")
];