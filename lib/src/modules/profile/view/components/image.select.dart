import 'package:flutter/material.dart';

import '../../../../shared/image.widget/image.widget.dart';
import '../../../../shared/image_process/single/pick.photo.dart';
import '../../../../utils/extensions/extensions.dart';
import '../../../../utils/transations/big.to.small.dart';
import '../../provider/profile.provider.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(this.notifier, {super.key});

  final ProfileProvider notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(100.0),
        onTap: !notifier.isEditable
            ? null
            : () async => await pickPhoto(context).then((pk) {
                  if (pk == null) return;
                  notifier.setImage(pk);
                }),
        child: Stack(
          children: [
            BigToSmallTransition(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                  border: Border.all(
                    color: context.theme.primaryColor,
                    width: 2.0,
                  ),
                ),
                child: notifier.image == null || !notifier.isEditable
                    // ? notifier.user?.imageWidget
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: ImageWidget(notifier.image!),
                      ),
              ),
            ),
            if (notifier.image == null && notifier.isEditable)
              Positioned(
                bottom: 3,
                right: 3,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100.0),
                  onTap: () async => await pickPhoto(context).then((pk) {
                    if (pk == null) return;
                    notifier.setImage(pk);
                  }),
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(4.0),
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 14.0,
                    ),
                  ),
                ),
              ),
            if (notifier.image != null && notifier.isEditable)
              Positioned(
                top: 3,
                right: 3,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100.0),
                  onTap: () => notifier.removeImage(),
                  child: Container(
                    padding: const EdgeInsetsDirectional.all(3.0),
                    decoration: BoxDecoration(
                      color: context.theme.primaryColor,
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Icon(
                      Icons.close,
                      color: context.theme.colorScheme.error,
                      size: 16.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
