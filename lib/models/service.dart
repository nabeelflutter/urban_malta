class ServiceModel {
  String imageUrl;
  String description;
  double price;

  ServiceModel({required this.description, required this.imageUrl, required this.price});
}

List<ServiceModel> tempserrvices = [
  ServiceModel(
      description: "bathroom Cleaning",
      imageUrl: "https://i.insider.com/5abab103e567b81d008b484f?width=1000&format=jpeg&auto=webp",
      price: 34.5),
  ServiceModel(
      description: "Car Cleaning",
      imageUrl:
          "https://inoutcarwash.com/wp-content/uploads/2021/09/best-car-cleaning-services-in-gurgaon.jpg",
      price: 23.5),
  ServiceModel(
      description: "Room Cleaning",
      imageUrl:
          "https://st.depositphotos.com/1177973/4299/i/950/depositphotos_42995381-stock-photo-cleaning-floor-in-room-close.jpg?forcejpeg=true",
      price: 90.5),
  ServiceModel(
      description: "Dish Washing",
      imageUrl:
          "https://static9.depositphotos.com/1667271/1143/i/950/depositphotos_11439425-stock-photo-woman-washing-dishes.jpg?forcejpeg=true",
      price: 12.5)
];
