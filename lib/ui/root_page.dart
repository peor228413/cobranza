import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cobranzas/constants.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/scan_page.dart';
import 'package:cobranzas/ui/screens/creditPage.dart';
import 'package:cobranzas/ui/screens/custom_drawerpage.dart';
import 'package:cobranzas/ui/screens/othersPage.dart';
import 'package:cobranzas/ui/screens/home_page.dart';
import 'package:cobranzas/ui/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _bottomNavIndex = 0;

  //List of the pages
  List<Widget> _widgetOptions() {
    return [
      const HomePage(), //HOMEPAGE
      const creditPage(),
      const othersPage(),
      const ProfilePage(),
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.home_sharp,
    Icons.add_card,
    Icons.more,
    Icons.account_box_rounded,
    //Icons.location_history_rounded,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Clientes',
    'Pagos',
    'Otros',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const DrawerPage(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu, // Cambia el ícono del botón del Drawer
              color: Constants
                  .orangeColor, // Cambia el color del ícono del botón del Drawer
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        automaticallyImplyLeading: true,
        title: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Text(
                      titleList[_bottomNavIndex],
                      style: TextStyle(
                        color: Constants.orangeColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  /*  IconButton(
                    icon: const Icon(
                      Icons.login_outlined,
                      color: Colors.orange,
                      size: 40,
                    ),
                    onPressed: () {
                      //
        
                      //   authenticationRepository().LogoOut();
                      authenticationRepository
                          .showcerrarSesion("¿Realmente quieres salir?");
        
                      //    SingUpController().emailLogin.dispose();
                      //    SingUpController().passwordlogin.dispose();
                    },
                  )*/
                ],
              ),
              Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        authenticationRepository.showcerrarSesion(
                            "¿Estás seguro que quieres cerrar sesión?",
                            context);
                      },
                      icon: const Icon(Icons.meeting_room_rounded,
                          color: Colors.orange),
                      label: const Text("Cerrar Sesión",
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.only(
                                  right: 10, left: 10, top: 10, bottom: 10)),
                          fixedSize: MaterialStatePropertyAll(size / 2),
                          iconSize: const MaterialStatePropertyAll(40.0),
                          //maximumSize: MaterialStateProperty.all(size),
                          minimumSize: MaterialStatePropertyAll(size * .2),
                          overlayColor: MaterialStatePropertyAll(
                              Colors.black.withOpacity(.5)),
                          elevation: const MaterialStatePropertyAll(0.0)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: IndexedStack(
        index: _bottomNavIndex,
        children: _widgetOptions(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const ScanPage(),
                  type: PageTransitionType.bottomToTop));
        },
        backgroundColor: Constants.blueColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Image.asset(
          'assets/images/code-scan-two.png',
          height: 25.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
          iconSize: 30,
          gapWidth: 120,
          blurEffect: true,
          splashRadius: 30,
          backgroundColor: Colors.blue.withOpacity(.1),
          elevation: 25.0,
          splashColor: Colors.orange,
          activeColor: Constants.orangeColor,
          inactiveColor: Constants.blueColor.withOpacity(.5),
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.smoothEdge,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;
            });
          }),
    );
  }
}
