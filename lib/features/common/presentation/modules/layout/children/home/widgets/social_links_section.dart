import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/utils/launch_links_and_apps/launch_links_and_apps_helper.dart';
import 'package:base_app/features/common/domain/entity/home_entity.dart';
import 'package:flutter/material.dart';

class SocialLinksSection extends StatelessWidget {
  final HomeEntity _entity;

  const SocialLinksSection({
    super.key,
    required HomeEntity entity,
  }) : _entity = entity;

  @override
  Widget build(BuildContext context) {
    final socialData = _entity.rawData as Map<String, dynamic>?;
    if (socialData == null || socialData.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: kCardPadding,
      child: Column(
        children: [
          if (_entity.title.isNotEmpty)
            Text(
              _entity.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).primaryColorLight,
              ),
              textAlign: TextAlign.center,
            ),
          VerticalSpace(kFormPaddingAllNormal.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (socialData['whatsapp'] != null && socialData['whatsapp'].toString().isNotEmpty)
                _buildSocialIcon(
                  context: context,
                  icon: Icons.chat_bubble_outline,
                  onTap: () {
                    final whatsapp = socialData['whatsapp'].toString();
                    if (whatsapp.startsWith('+') || whatsapp.startsWith('00')) {
                      LaunchHelper.whatsApp(phone: whatsapp.replaceAll(' ', ''));
                    } else {
                      LaunchHelper.link(link: whatsapp);
                    }
                  },
                ),
              if (socialData['linkedin'] != null && socialData['linkedin'].toString().isNotEmpty)
                _buildSocialIcon(
                  context: context,
                  icon: Icons.business_center,
                  onTap: () => LaunchHelper.link(link: socialData['linkedin'].toString()),
                ),
              if (socialData['instagram'] != null && socialData['instagram'].toString().isNotEmpty)
                _buildSocialIcon(
                  context: context,
                  icon: Icons.camera_alt_outlined,
                  onTap: () => LaunchHelper.link(link: socialData['instagram'].toString()),
                ),
              if (socialData['twitter'] != null && socialData['twitter'].toString().isNotEmpty)
                _buildSocialIcon(
                  context: context,
                  icon: Icons.alternate_email,
                  onTap: () => LaunchHelper.link(link: socialData['twitter'].toString()),
                ),
              if (socialData['facebook'] != null && socialData['facebook'].toString().isNotEmpty)
                _buildSocialIcon(
                  context: context,
                  icon: Icons.facebook,
                  onTap: () => LaunchHelper.link(link: socialData['facebook'].toString()),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kFormPaddingAllSmall.w),
        width: 48.w,
        height: 48.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColorDark.withOpacity(0.1),
          border: Border.all(
            color: Theme.of(context).primaryColorLight.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColorLight,
          size: 24.sp,
        ),
      ),
    );
  }
}
