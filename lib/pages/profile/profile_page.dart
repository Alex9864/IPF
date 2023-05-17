import 'package:flutter/material.dart';
import 'package:ipf/pages/shared/widgets/custom_button.dart';
import 'package:ipf/pages/welcome/welcome_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  int? _choice = 1;
  final RoundedLoadingButtonController _disconnectBtnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back),
                    ),
                    SizedBox(height: 1,)
                  ],
                ),
                SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://picsum.photos/seed/353/600',
                    width: 130,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 25,),
                Text(
                  'Alex',
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
}
