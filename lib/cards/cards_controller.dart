import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pbgrpc.dart';
import 'package:sample/main/widgets/main_tabbar.dart';
import 'package:sample/routes/routes.dart';
import '../service/repository/cards_repo.dart';

enum CardsMenuItems { cardLimits, changePIN, freezeCard, closeCard }

extension CardsMenuItemsTitle on CardsMenuItems {
  String title() {
    switch (this) {
      case CardsMenuItems.cardLimits:
        return "Card Limits";
      case CardsMenuItems.changePIN:
        return "Change PIN";
      case CardsMenuItems.freezeCard:
        return "Freeze card";
      case CardsMenuItems.closeCard:
        return "Close card";
    }
  }
}

class CardsController extends MainTabController  {
  static CardsController get() => Get.find();

  PageController pageController = PageController(viewportFraction: 0.85);

  bool canPop() => false;

  final CardsRepo cardsRepo;

  final _isLoaded = false.obs;
  final _isLoading = false.obs;

  CardsController({required this.cardsRepo});

  final List<PaymentCard> _cardsList = [];
  bool get isLoaded => _isLoaded();
  bool get isLoading => _isLoading();

  List<CardsMenuItems> get cardsMenuItems => CardsMenuItems.values;
  List<PaymentCard> get cardsList => _cardsList;

  var currPageValue = 0.0;

  void onCardTapped(int id) {
    print("did tap card id $id");
  }



  @override
  void onTabOpen() {
    super.onTabOpen();
    reloadData();
  }

  @override
  void onInit() {
    super.onInit();
    reloadData();
    pageController.addListener(() {
      currPageValue = pageController.page!;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onMenuItemTapped(int index, BuildContext context) {
    switch (cardsMenuItems[index]){
      case CardsMenuItems.cardLimits:
        Get.toNamed(Routes.CARDS_DETAILS);
        break;
        default:
          break;
    }
  }

  Future<dynamic> reloadData() async {
    update();
    await _getCardModelList();
  }

  Future<dynamic> _getCardModelList() async {
    _isLoaded(false);
    _isLoading(true);

   print("getCardModelList() started");

   try {
     final result = await cardsRepo.getCards();
     if (result != null && result.cards.length > 0) {
       final resData = result.cards;
       _cardsList.clear();
       for (int i=0; i < resData.length; i++) {
         _cardsList.add(resData[i]);
       }
       _isLoaded(true);
       print("getCardModelList() loaded: " + resData.toString());
     } else {
       _isLoaded(false);
       print("getCardModelList() loaded: " +  "false");
     }
     _isLoading(false);
     update();
   } catch (error) {
    _isLoading(false);
    print("getCardModelList() failed with error: " + error.toString());
     update();
    }
  }

}