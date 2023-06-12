import 'package:flutter/material.dart';
import 'package:ipf/pages/image%20model/image_model.dart';
import 'package:ipf/pages/shared/widgets/custom_button.dart';
import 'package:ipf/pages/welcome/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int? _choice = 0;
  int? _choice1 = 0;

  final RoundedLoadingButtonController _disconnectBtnController = RoundedLoadingButtonController();
  List<String> imagesSelectionnables = [
    'assets/images/Avatars/chauve-souris.png',
    'assets/images/Avatars/colombe.png',
    'assets/images/Avatars/crabe.png',
    'assets/images/Avatars/dauphin.png',
    'assets/images/Avatars/dinosaure.png',
    'assets/images/Avatars/girafe.png',
    'assets/images/Avatars/lapin.png',
    'assets/images/Avatars/lelephant.png',
    'assets/images/Avatars/manchot.png',
    'assets/images/Avatars/papillon.png',
    'assets/images/Avatars/perroquet.png',
    'assets/images/Avatars/poisson.png',
    'assets/images/Avatars/renard.png',
    'assets/images/Avatars/star.png',
    'assets/images/Avatars/tulipe.png',
  ];

  @override
  Widget build(BuildContext context) {

    final imageModel = Provider.of<ImageModel>(context);
    String imagePrincipale = imageModel.selectedImage;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Stack(
                  children: [
                    Image.asset(
                      imagePrincipale,
                      width: 130,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      bottom: -15,
                      right: -15,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _afficherListeImages();
                        },
                      ),
                    ),
                  ]
                ),
                SizedBox(height: 25,),
                Text(
                  'Alexandre',
                  style:
                  TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Language',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(2,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['English', 'Français'][index], style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: _choice == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _choice = selected ? index : null;
                          });
                        },
                      ),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 25),
                Text(
                  'Remind me to do my daily questionnaire every morning',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Wrap(
                  children: List.generate(2,(int index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: ChoiceChip(
                        padding: EdgeInsets.all(8),
                        label: Text(['Yes', 'No'][index], style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),),
                        selectedColor: Colors.greenAccent,
                        selected: _choice1 == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _choice1 = selected ? index : null;
                          });
                        },
                      ),
                    );
                  },
                  ).toList(),
                ),
                SizedBox(height: 25),
                RoundedLoadingButton(
                  child: Text(
                    'Disconnect',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.redAccent,
                  controller: _disconnectBtnController,
                  onPressed: () => _onClickDisconnectButton()
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _onClickDisconnectButton(){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const WelcomePage()
        )
    );
    _disconnectBtnController.stop();
  }

  void _afficherListeImages() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Nombre de colonnes souhaité
                      childAspectRatio: 1, // Ratio pour conserver le format carré
                      mainAxisSpacing: 20, // Espacement vertical entre les images
                      crossAxisSpacing: 20, // Espacement horizontal entre les images
                    ),
                    itemCount: imagesSelectionnables.length,
                    itemBuilder: (BuildContext context, int index) {
                      String imagePath = imagesSelectionnables[index];
                      return GestureDetector(
                        onTap: () {
                          changerImage(imagePath);
                        },
                        child: Image.asset(imagePath),
                      );
                    },
                  ),
                ),
              ),
              ElevatedButton(
                child: Text('Appliquer'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void changerImage(String nouvelleImage) {
    final imageModel = Provider.of<ImageModel>(context, listen: false);
    imageModel.changeImage(nouvelleImage);
  }
}
