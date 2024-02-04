import 'package:bcsports_mobile/features/profile/data/profile_repository.dart';
import 'package:bcsports_mobile/features/profile/widgets/Nft_item.dart';
import 'package:bcsports_mobile/features/profile/widgets/toggle_bottom.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/enums.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final sizeof = MediaQuery.sizeOf(context);

    final repository = RepositoryProvider.of<ProfileRepository>(context);

    const separator = SliverToBoxAdapter(
      child: SizedBox(
        height: 20,
      ),
    );

    return Container(
      color: AppColors.black_090723,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Scaffold(
            backgroundColor: AppColors.black_090723,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 120,
                        ),
                      ],
                    ),
                    Text(
                      'Profile',
                      style: AppFonts.font18w600,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: AppColors.white,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/profile_settings');
                          },
                        ),
                      ],
                    )
                  ],
                )),
            body: CustomScrollView(slivers: [
              separator,
              SliverToBoxAdapter(
                child: SizedBox(
                  height: sizeof.width * 0.70,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: sizeof.width * 0.50,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: CircleAvatar(
                          radius: sizeof.width * 0.20,
                          backgroundColor: AppColors.black_090723,
                          child: CircleAvatar(
                            radius: sizeof.width * 0.18,
                            child: const ColoredBox(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              separator,
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Text(
                      'Andrian',
                      style: AppFonts.font20w600,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '@ideasbyandian',
                      style: AppFonts.font13w100,
                    ),
                  ],
                ),
              ),
              separator,
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ToggleButton(
                      width: sizeof.width * 0.4,
                      enumTap: EnumProfileTab.Nft,
                      text: 'NFT',
                      onTap: () {
                        repository.setProfileActiveTap(EnumProfileTab.Nft);
                        setState(() {});
                      },
                    ),
                    ToggleButton(
                      width: sizeof.width * 0.4,
                      enumTap: EnumProfileTab.Posts,
                      text: 'Posts',
                      onTap: () {
                        repository.setProfileActiveTap(EnumProfileTab.Posts);
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              separator,
              separator,
              SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 30.0,
                    childAspectRatio: 0.615,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return NftItemWidget(
                        width: sizeof.width * 0.43,
                        height: sizeof.width * 0.7,
                      );
                    },
                    childCount: 20,
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
