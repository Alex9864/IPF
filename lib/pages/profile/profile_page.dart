import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String selectedAvatar = "";
  String previousAvatar = "";

  final db = FirebaseFirestore.instance;

  final RoundedLoadingButtonController _disconnectBtnController = RoundedLoadingButtonController();
  List<String> imagesSelectionnables = [
    'chauve-souris',
    'colombe',
    'crabe',
    'dauphin',
    'dinosaure',
    'girafe',
    'lapin',
    'lelephant',
    'manchot',
    'papillon',
    'perroquet',
    'poisson',
    'renard',
    'star',
    'tulipe',
  ];

  @override
  void initState() {
    super.initState();
    final imageModel = Provider.of<ImageModel>(context, listen: false);
    previousAvatar = imageModel.avatar;
  }

  @override
  Widget build(BuildContext context) {

    final imageModel = Provider.of<ImageModel>(context);
    String avatar = imageModel.avatar;
    String role = Provider.of<ImageModel>(context).role;
    String firstName = Provider.of<ImageModel>(context).firstName;

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
                      'assets/images/Avatars/'+ avatar + '.png',
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
                  firstName,
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
                if (role == "User") ...[
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
                  )
                ],
                SizedBox(height: 25),
                RoundedLoadingButton(
                  child: Text(
                    'Log Out',
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
    FirebaseAuth.instance.signOut();
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
                      String imagePath = 'assets/images/Avatars/'+ imagesSelectionnables[index] + '.png';
                      return GestureDetector(
                        onTap: () {
                          changerImage(imagesSelectionnables[index]);
                          selectedAvatar = imagesSelectionnables[index];
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
                  changerImageDB(selectedAvatar);
                  previousAvatar = selectedAvatar;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      changerImage(previousAvatar);
    });
  }

  void changerImage(String nouvelleImage) {
    final imageModel = Provider.of<ImageModel>(context, listen: false);
    imageModel.setAvatar(nouvelleImage);
  }

  Future<void> changerImageDB(String nouvelleImage) async {
    final user = FirebaseAuth.instance.currentUser!;
    final DocumentReference _docRef = db.collection('users').doc(user.email!);

    _docRef.update({'Avatar': nouvelleImage});
  }
}
